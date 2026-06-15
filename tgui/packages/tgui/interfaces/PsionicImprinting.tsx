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

const groupByTier = (powers: PsionicPower[]) => {
  const grouped: Record<number, PsionicPower[]> = {};

  for (const power of powers) {
    grouped[power.tier] ??= [];
    grouped[power.tier].push(power);
  }

  return Object.entries(grouped)
    .map(([tier, tierPowers]) => ({
      tier: Number(tier),
      powers: tierPowers.sort((first, second) => first.cost - second.cost),
    }))
    .sort((first, second) => first.tier - second.tier);
};

const getTierName = (tier: number) => {
  return tierNames[tier - 1] || `Depth ${tier}`;
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
  const groupedPowers = groupByTier(school.powers);

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
      <Stack vertical className="PsionicImprinting__tierTrack">
        {groupedPowers.map((tier) => (
          <Stack.Item key={tier.tier}>
            <Box
              className="PsionicImprinting__tier"
              style={{ borderColor: school.color }}
            >
              <Box className="PsionicImprinting__tierTitle">
                {getTierName(tier.tier)}
              </Box>
              <Stack wrap="wrap">
                {tier.powers.map((power) => (
                  <Stack.Item key={power.action_type}>
                    <PowerNode power={power} school={school} />
                  </Stack.Item>
                ))}
              </Stack>
            </Box>
          </Stack.Item>
        ))}
      </Stack>
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
          <Box bold textAlign="center">
            {power.name}
          </Box>
        </Stack.Item>
        <Stack.Item>
          <Box color="label" textAlign="center">
            {learned
              ? 'Imprinted'
              : `${power.cost} point${power.cost === 1 ? '' : 's'}`}
          </Box>
        </Stack.Item>
        {!!power.required_school_points && (
          <Stack.Item>
            <Box color="label" textAlign="center" fontSize="11px">
              Branch {power.required_school_points}
            </Box>
          </Stack.Item>
        )}
      </Stack>
    </Button>
  );
};
