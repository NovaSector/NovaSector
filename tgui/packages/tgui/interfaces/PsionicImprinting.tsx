import '../styles/interfaces/PsionicImprinting.scss';

import { useState } from 'react';
import {
  Box,
  Button,
  DmIcon,
  ProgressBar,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type PsionicPower = {
  action_type: string;
  name: string;
  desc: string;
  cost: number;
  required_school_points: number;
  required_powers: string[];
  tier: number;
  learned: BooleanLike;
  can_buy: BooleanLike;
  lock_reason?: string;
  icon: string;
  icon_state: string;
};

type PsionicSchool = {
  id: string;
  key: string;
  name: string;
  desc: string;
  spent_points: number;
  attuned: BooleanLike;
  strain_discount: number;
  icon: string;
  icon_state: string;
  color: string;
  powers: PsionicPower[];
};

type PsionicImprintingData = {
  rank: string;
  rank_text: string;
  potential_rank: string;
  rank_limited: BooleanLike;
  available_points: number;
  spent_points: number;
  strain: number;
  max_strain: number;
  schools: PsionicSchool[];
};

const tierNames = [
  'Sensitivity',
  'Operancy',
  'Mastery',
  'Grandmastery',
  'Paramount',
];

const POWER_NODE_WIDTH = 140;
const POWER_NODE_HEIGHT = 140;
const POWER_NODE_GAP = 20;
const POWER_ROW_GAP = 58;
const POWER_TIER_LABEL_WIDTH = 92;
const POWER_MAP_PADDING = 14;
const MAX_POWER_COLUMNS = 3;

type PowerLayoutNode = {
  power: PsionicPower;
  x: number;
  y: number;
};

type PowerLayoutRow = {
  tier: number;
  y: number;
  showTitle: boolean;
};

type PowerLayoutConnection = {
  key: string;
  from: PowerLayoutNode;
  to: PowerLayoutNode;
  state: 'available' | 'complete' | 'locked';
};

type PowerLayout = {
  nodes: PowerLayoutNode[];
  rows: PowerLayoutRow[];
  connections: PowerLayoutConnection[];
  width: number;
  height: number;
};

const getTierName = (tier: number) => {
  return tierNames[tier - 1] || `Depth ${tier}`;
};

const getPowerDependencyColumn = (
  power: PsionicPower,
  placedColumns: Map<string, number>,
) => {
  let total = 0;
  let count = 0;

  for (const requiredPower of power.required_powers || []) {
    const column = placedColumns.get(requiredPower);
    if (column === undefined) {
      continue;
    }

    total += column;
    count++;
  }

  return count ? total / count : Infinity;
};

const sortPowersForLayout = (
  powers: PsionicPower[],
  placedColumns: Map<string, number>,
) => {
  return [...powers].sort((first, second) => {
    const firstDependencyColumn = getPowerDependencyColumn(
      first,
      placedColumns,
    );
    const secondDependencyColumn = getPowerDependencyColumn(
      second,
      placedColumns,
    );

    if (firstDependencyColumn !== secondDependencyColumn) {
      return firstDependencyColumn - secondDependencyColumn;
    }

    if (first.required_school_points !== second.required_school_points) {
      return first.required_school_points - second.required_school_points;
    }

    if (first.cost !== second.cost) {
      return first.cost - second.cost;
    }

    return first.name.localeCompare(second.name);
  });
};

const getConnectionState = (
  requiredNode: PowerLayoutNode,
  dependentNode: PowerLayoutNode,
): PowerLayoutConnection['state'] => {
  if (dependentNode.power.learned) {
    return 'complete';
  }

  if (requiredNode.power.learned) {
    return 'available';
  }

  return 'locked';
};

const buildPowerLayout = (powers: PsionicPower[]): PowerLayout => {
  const powersByTier: Record<number, PsionicPower[]> = {};
  for (const power of powers) {
    powersByTier[power.tier] ??= [];
    powersByTier[power.tier].push(power);
  }

  const tierGroups = Object.entries(powersByTier)
    .map(([tier, tierPowers]) => ({ tier: Number(tier), powers: tierPowers }))
    .sort((first, second) => first.tier - second.tier);

  const nodes: PowerLayoutNode[] = [];
  const rows: PowerLayoutRow[] = [];
  const nodeByAction = new Map<string, PowerLayoutNode>();
  const placedColumns = new Map<string, number>();
  let rowIndex = 0;

  for (const tierGroup of tierGroups) {
    const orderedPowers = sortPowersForLayout(tierGroup.powers, placedColumns);

    for (
      let index = 0;
      index < orderedPowers.length;
      index += MAX_POWER_COLUMNS
    ) {
      const rowPowers = orderedPowers.slice(index, index + MAX_POWER_COLUMNS);
      const y =
        POWER_MAP_PADDING + rowIndex * (POWER_NODE_HEIGHT + POWER_ROW_GAP);
      rows.push({
        tier: tierGroup.tier,
        y,
        showTitle: index === 0,
      });

      rowPowers.forEach((power, column) => {
        const node = {
          power,
          x:
            POWER_TIER_LABEL_WIDTH +
            POWER_MAP_PADDING +
            column * (POWER_NODE_WIDTH + POWER_NODE_GAP),
          y,
        };
        nodes.push(node);
        nodeByAction.set(power.action_type, node);
        placedColumns.set(power.action_type, column);
      });

      rowIndex++;
    }
  }

  const connections: PowerLayoutConnection[] = [];
  for (const node of nodes) {
    for (const requiredPower of node.power.required_powers || []) {
      const requiredNode = nodeByAction.get(requiredPower);
      if (!requiredNode || requiredNode === node) {
        continue;
      }

      connections.push({
        key: `${requiredPower}->${node.power.action_type}`,
        from: requiredNode,
        to: node,
        state: getConnectionState(requiredNode, node),
      });
    }
  }

  return {
    nodes,
    rows,
    connections,
    width:
      POWER_TIER_LABEL_WIDTH +
      POWER_MAP_PADDING * 2 +
      MAX_POWER_COLUMNS * POWER_NODE_WIDTH +
      (MAX_POWER_COLUMNS - 1) * POWER_NODE_GAP,
    height: rows.length
      ? POWER_MAP_PADDING * 2 +
        rows.length * POWER_NODE_HEIGHT +
        (rows.length - 1) * POWER_ROW_GAP
      : 0,
  };
};

const getConnectionPath = (connection: PowerLayoutConnection) => {
  const startX = connection.from.x + POWER_NODE_WIDTH / 2;
  const startY = connection.from.y + POWER_NODE_HEIGHT;
  const endX = connection.to.x + POWER_NODE_WIDTH / 2;
  const endY = connection.to.y;

  if (connection.from.y === connection.to.y) {
    const middleY = connection.from.y + POWER_NODE_HEIGHT / 2;
    return [
      `M ${connection.from.x + POWER_NODE_WIDTH} ${middleY}`,
      `C ${connection.from.x + POWER_NODE_WIDTH + POWER_NODE_GAP / 2} ${middleY},`,
      `${connection.to.x - POWER_NODE_GAP / 2} ${middleY},`,
      `${connection.to.x} ${middleY}`,
    ].join(' ');
  }

  const curve = Math.max((endY - startY) / 2, 24);
  return [
    `M ${startX} ${startY}`,
    `C ${startX} ${startY + curve},`,
    `${endX} ${endY - curve},`,
    `${endX} ${endY}`,
  ].join(' ');
};

export const PsionicImprinting = () => {
  const { data } = useBackend<PsionicImprintingData>();
  const { schools = [] } = data;
  const [selectedSchoolId, setSelectedSchoolId] = useState<string | undefined>(
    schools[0]?.id,
  );

  const selectedSchool =
    schools.find((school) => school.id === selectedSchoolId) || schools[0];

  return (
    <Window width={800} height={640} theme="ntos">
      <Window.Content
        className={[
          'PsionicImprinting',
          selectedSchool && `PsionicImprinting--${selectedSchool.key}`,
        ]
          .filter(Boolean)
          .join(' ')}
      >
        <Stack vertical fill>
          <Stack.Item>
            <Header />
          </Stack.Item>
          <Stack.Item grow>
            <Stack fill>
              <Stack.Item width="190px">
                <Section fill>
                  <Tabs vertical fluid>
                    {schools.map((school) => (
                      <Tabs.Tab
                        key={school.id}
                        selected={selectedSchool?.id === school.id}
                        onClick={() => setSelectedSchoolId(school.id)}
                      >
                        <Stack align="center">
                          <Stack.Item>
                            <Box
                              className="PsionicImprinting__schoolSwatch"
                              style={{ backgroundColor: school.color }}
                            />
                          </Stack.Item>
                          <Stack.Item>
                            <DmIcon
                              icon={school.icon}
                              icon_state={school.icon_state}
                              width="20px"
                              height="20px"
                            />
                          </Stack.Item>
                          <Stack.Item grow>{school.name}</Stack.Item>
                          <Stack.Item color="label">
                            {school.spent_points}
                          </Stack.Item>
                        </Stack>
                      </Tabs.Tab>
                    ))}
                  </Tabs>
                </Section>
              </Stack.Item>
              <Stack.Item grow>
                {selectedSchool ? (
                  <SchoolBranch school={selectedSchool} />
                ) : (
                  <Section fill>No psionic schools are available.</Section>
                )}
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

const Header = () => {
  const { data } = useBackend<PsionicImprintingData>();
  const strainRatio = data.max_strain ? data.strain / data.max_strain : 0;

  return (
    <Section>
      <Stack align="center">
        <Stack.Item grow>
          <Box className="PsionicImprinting__title">Psionic Imprinting</Box>
          <Box color="label">
            Rank {data.rank_text}
            {!!data.rank_limited && ` | latent ${data.potential_rank}`}
          </Box>
        </Stack.Item>
        <Stack.Item width="160px">
          <Box color="label">Imprint points</Box>
          <Box fontSize="24px" bold>
            {data.available_points}
          </Box>
        </Stack.Item>
        <Stack.Item width="210px">
          <Box color="label">Strain</Box>
          <ProgressBar
            value={strainRatio}
            ranges={{
              good: [0, 0.5],
              average: [0.5, 0.75],
              bad: [0.75, Infinity],
            }}
          >
            {data.strain}/{data.max_strain}
          </ProgressBar>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const SchoolBranch = (props: { school: PsionicSchool }) => {
  const { school } = props;
  const powerLayout = buildPowerLayout(school.powers);

  return (
    <Section
      fill
      scrollable
      title={
        <Stack align="center">
          <Stack.Item>
            <DmIcon
              icon={school.icon}
              icon_state={school.icon_state}
              width="32px"
              height="32px"
            />
          </Stack.Item>
          <Stack.Item>
            <Box style={{ color: school.color }}>{school.name}</Box>
          </Stack.Item>
        </Stack>
      }
    >
      <Box
        className="PsionicImprinting__schoolSummary"
        style={{ borderColor: school.color }}
      >
        <Box>{school.desc}</Box>
        <Box color="label">
          Points imprinted in branch: {school.spent_points}
        </Box>
        {!!school.strain_discount && (
          <Box color="good">
            Strain discount: {school.strain_discount}%
            {!!school.attuned && ' | core attuned'}
          </Box>
        )}
      </Box>
      <Box
        className="PsionicImprinting__powerMap"
        style={{
          color: school.color,
          height: `${powerLayout.height}px`,
          width: `${powerLayout.width}px`,
        }}
      >
        <svg
          className="PsionicImprinting__dependencyLines"
          width={powerLayout.width}
          height={powerLayout.height}
          viewBox={`0 0 ${powerLayout.width} ${powerLayout.height}`}
          aria-hidden="true"
        >
          {powerLayout.connections.map((connection) => (
            <g key={connection.key}>
              <path
                className={[
                  'PsionicImprinting__dependencyLine',
                  `PsionicImprinting__dependencyLine--${connection.state}`,
                ].join(' ')}
                d={getConnectionPath(connection)}
              />
              <circle
                className={[
                  'PsionicImprinting__dependencyPoint',
                  `PsionicImprinting__dependencyPoint--${connection.state}`,
                ].join(' ')}
                cx={connection.to.x + POWER_NODE_WIDTH / 2}
                cy={connection.to.y}
                r="3"
              />
            </g>
          ))}
        </svg>
        {powerLayout.rows.map((row, index) => (
          <Box
            key={`${row.tier}-${index}`}
            className="PsionicImprinting__tierLabel"
            style={{ top: `${row.y + POWER_NODE_HEIGHT / 2 - 8}px` }}
          >
            {row.showTitle && getTierName(row.tier)}
          </Box>
        ))}
        {powerLayout.nodes.map((node) => (
          <Box
            key={node.power.action_type}
            className="PsionicImprinting__nodeSlot"
            style={{
              left: `${node.x}px`,
              top: `${node.y}px`,
            }}
          >
            <PowerNode power={node.power} school={school} />
          </Box>
        ))}
      </Box>
    </Section>
  );
};

const PowerNode = (props: { power: PsionicPower; school: PsionicSchool }) => {
  const { act } = useBackend<PsionicImprintingData>();
  const { power, school } = props;
  const learned = !!power.learned;
  const canBuy = !!power.can_buy;
  const disabled = learned || !canBuy;

  return (
    <Button
      className={[
        'PsionicImprinting__node',
        learned && 'PsionicImprinting__node--learned',
        !learned && !canBuy && 'PsionicImprinting__node--locked',
      ]
        .filter(Boolean)
        .join(' ')}
      color="transparent"
      disabled={disabled}
      tooltip={
        power.lock_reason
          ? `${power.name}: ${power.desc} ${power.lock_reason}`
          : `${power.name}: ${power.desc}`
      }
      onClick={() => act('imprint', { action_type: power.action_type })}
      style={{ borderColor: school.color }}
    >
      <Stack vertical align="center" fill>
        <Stack.Item>
          <Box
            className="PsionicImprinting__nodeIcon"
            style={{ boxShadow: `0 0 14px ${school.color}` }}
          >
            <DmIcon
              icon={power.icon}
              icon_state={power.icon_state}
              width="32px"
              height="32px"
            />
          </Box>
        </Stack.Item>
        <Stack.Item>
          <Box bold textAlign="center" className="PsionicImprinting__nodeName">
            {power.name}
          </Box>
        </Stack.Item>
        <Stack.Item>
          <Box
            color="label"
            textAlign="center"
            className="PsionicImprinting__nodeMeta"
          >
            {learned
              ? 'Imprinted'
              : `${power.cost} point${power.cost === 1 ? '' : 's'}`}
          </Box>
        </Stack.Item>
        {!!power.required_school_points && (
          <Stack.Item>
            <Box
              color="label"
              textAlign="center"
              className="PsionicImprinting__nodeMeta"
            >
              Branch {power.required_school_points}
            </Box>
          </Stack.Item>
        )}
      </Stack>
    </Button>
  );
};
