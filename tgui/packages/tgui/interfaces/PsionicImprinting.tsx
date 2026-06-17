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
  required_power_names: string[];
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

const POWER_NODE_WIDTH = 420;
const POWER_NODE_MIN_HEIGHT = 126;
const POWER_NODE_GAP = 18;
const POWER_NODE_X = 56;
const POWER_CONNECTOR_X = 28;
const POWER_MAP_PADDING = 0;
const POWER_TEXT_CHARS_PER_LINE = 42;

type PowerLayoutNode = {
  power: PsionicPower;
  x: number;
  y: number;
  height: number;
};

type PowerLayoutConnection = {
  key: string;
  from: PowerLayoutNode;
  to: PowerLayoutNode;
  state: 'available' | 'complete' | 'locked';
};

type PowerLayout = {
  nodes: PowerLayoutNode[];
  connections: PowerLayoutConnection[];
  width: number;
  height: number;
};

const getTierName = (tier: number) => {
  return tierNames[tier - 1] || `Depth ${tier}`;
};

const getEstimatedLineCount = (text: string) => {
  return Math.max(1, Math.ceil(text.length / POWER_TEXT_CHARS_PER_LINE));
};

const getPowerNodeHeight = (power: PsionicPower) => {
  const prereqText = power.required_power_names?.length
    ? `Prereq: ${power.required_power_names.join(', ')}`
    : '';
  const descLines = getEstimatedLineCount(power.desc || '');
  const prereqLines = prereqText ? getEstimatedLineCount(prereqText) : 0;
  const textHeight = 17 + descLines * 15 + 16 + prereqLines * 16;

  return Math.max(POWER_NODE_MIN_HEIGHT, textHeight + 26);
};

const comparePowersForLayout = (first: PsionicPower, second: PsionicPower) => {
  if (first.tier !== second.tier) {
    return first.tier - second.tier;
  }

  if (first.required_school_points !== second.required_school_points) {
    return first.required_school_points - second.required_school_points;
  }

  if (first.cost !== second.cost) {
    return first.cost - second.cost;
  }

  return first.name.localeCompare(second.name);
};

const sortPowersForLayout = (powers: PsionicPower[]) => {
  const schoolPowerTypes = new Set(powers.map((power) => power.action_type));
  const placedPowerTypes = new Set<string>();
  const remainingPowers = [...powers].sort(comparePowersForLayout);
  const orderedPowers: PsionicPower[] = [];

  while (remainingPowers.length) {
    const readyPowerIndex = remainingPowers.findIndex((power) =>
      (power.required_powers || []).every(
        (requiredPower) =>
          !schoolPowerTypes.has(requiredPower) ||
          placedPowerTypes.has(requiredPower),
      ),
    );
    const nextPower = remainingPowers.splice(
      readyPowerIndex >= 0 ? readyPowerIndex : 0,
      1,
    )[0];
    orderedPowers.push(nextPower);
    placedPowerTypes.add(nextPower.action_type);
  }

  return orderedPowers;
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
  const nodes: PowerLayoutNode[] = [];
  const nodeByAction = new Map<string, PowerLayoutNode>();
  const orderedPowers = sortPowersForLayout(powers);
  let nextNodeY = POWER_MAP_PADDING;

  orderedPowers.forEach((power) => {
    const height = getPowerNodeHeight(power);
    const node = {
      power,
      x: POWER_NODE_X,
      y: nextNodeY,
      height,
    };
    nodes.push(node);
    nodeByAction.set(power.action_type, node);
    nextNodeY += height + POWER_NODE_GAP;
  });

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
    connections,
    width: POWER_NODE_X + POWER_NODE_WIDTH + POWER_MAP_PADDING,
    height: nodes.length ? nextNodeY - POWER_NODE_GAP + POWER_MAP_PADDING : 0,
  };
};

const getConnectionPath = (connection: PowerLayoutConnection) => {
  const startX = connection.from.x;
  const startY = connection.from.y + connection.from.height / 2;
  const endX = connection.to.x;
  const endY = connection.to.y + connection.to.height / 2;

  return [
    `M ${startX} ${startY}`,
    `H ${POWER_CONNECTOR_X}`,
    `V ${endY}`,
    `H ${endX}`,
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
                cx={POWER_CONNECTOR_X}
                cy={connection.to.y + connection.to.height / 2}
                r="3"
              />
            </g>
          ))}
        </svg>
        {powerLayout.nodes.map((node) => (
          <Box
            key={node.power.action_type}
            className="PsionicImprinting__nodeSlot"
            style={{
              left: `${node.x}px`,
              top: `${node.y}px`,
              height: `${node.height}px`,
            }}
          >
            <PowerNode power={node.power} school={school} />
          </Box>
        ))}
      </Box>
    </Section>
  );
};

const PowerNode = (props: {
  power: PsionicPower;
  school: PsionicSchool;
}) => {
  const { act } = useBackend<PsionicImprintingData>();
  const { power, school } = props;
  const learned = !!power.learned;
  const canBuy = !!power.can_buy;
  const disabled = learned || !canBuy;
  const requiredPowerNames = power.required_power_names || [];

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
      <Stack align="center" fill>
        <Stack.Item>
          <Box
            className="PsionicImprinting__nodeIcon"
            style={{ boxShadow: `0 0 10px ${school.color}` }}
          >
            <DmIcon
              icon={power.icon}
              icon_state={power.icon_state}
              width="32px"
              height="32px"
            />
          </Box>
        </Stack.Item>
        <Stack.Item grow>
          <Box bold className="PsionicImprinting__nodeName">
            {power.name}
          </Box>
          <Box color="label" className="PsionicImprinting__nodeDesc">
            {power.desc}
          </Box>
          <Box color="label" className="PsionicImprinting__nodeMeta">
            {getTierName(power.tier)}
            {!!power.required_school_points &&
              ` | Branch ${power.required_school_points}`}
          </Box>
          {!!requiredPowerNames.length && (
            <Box color="label" className="PsionicImprinting__nodeMeta">
              Prereq: {requiredPowerNames.join(', ')}
            </Box>
          )}
        </Stack.Item>
        <Stack.Item width="74px" textAlign="right">
          <Box className="PsionicImprinting__nodeCost">
            {learned
              ? 'Imprinted'
              : `${power.cost} point${power.cost === 1 ? '' : 's'}`}
          </Box>
        </Stack.Item>
      </Stack>
    </Button>
  );
};
