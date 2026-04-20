import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
  Stack,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type OccupantData = {
  name: string;
  health: number;
  maxHealth: number;
  bruteLoss: number;
  fireLoss: number;
  toxLoss: number;
  oxyLoss: number;
  stat: number;
};

type ItemData = {
  name: string;
  ref: string;
  isOrgan: BooleanLike;
};

type QueueEntry = ItemData & {
  action: 'insert' | 'remove';
};

type PatientItem = {
  name: string;
  ref: string;
};

type Data = {
  open: BooleanLike;
  operating: BooleanLike;
  hasAccess: BooleanLike;
  maxStorage: number;
  procedureTime: number;
  occupant: OccupantData | null;
  storedItems: ItemData[];
  queue: QueueEntry[];
  patientOrgans: PatientItem[];
  patientImplants: PatientItem[];
};

const STAT_LABELS: Record<number, { label: string; color: string }> = {
  0: { label: 'Conscious', color: 'good' },
  1: { label: 'Unconscious', color: 'average' },
  2: { label: 'Unconscious', color: 'average' },
  3: { label: 'Critical', color: 'bad' },
  4: { label: 'Dead', color: 'bad' },
};

const DAMAGE_TYPES = [
  { label: 'Brute', key: 'bruteLoss' as const },
  { label: 'Burn', key: 'fireLoss' as const },
  { label: 'Toxin', key: 'toxLoss' as const },
  { label: 'Oxygen', key: 'oxyLoss' as const },
];

export function InterdyneAutodoc() {
  const { act, data } = useBackend<Data>();
  const {
    open,
    operating,
    hasAccess,
    maxStorage,
    procedureTime,
    occupant,
    storedItems,
    queue,
    patientOrgans,
    patientImplants,
  } = data;

  const statInfo = occupant ? STAT_LABELS[occupant.stat] || STAT_LABELS[0] : null;

  return (
    <Window title="Interdyne Autodoc" width={420} height={620} theme="interdyne">
      <Window.Content>
        <Stack vertical fill>
          {/* Patient Section */}
          <Stack.Item>
            <Section
              title={occupant ? occupant.name : 'No Patient'}
              buttons={
                <Stack>
                  {occupant && statInfo && (
                    <Stack.Item>
                      <Box inline bold color={statInfo.color}>
                        {statInfo.label}
                      </Box>
                    </Stack.Item>
                  )}
                  <Stack.Item>
                    <Button
                      icon={open ? 'door-open' : 'door-closed'}
                      content={open ? 'Open' : 'Closed'}
                      disabled={!!operating}
                      onClick={() => act('door')}
                    />
                  </Stack.Item>
                </Stack>
              }
            >
              {occupant ? (
                <>
                  <ProgressBar
                    value={occupant.health}
                    minValue={-100}
                    maxValue={occupant.maxHealth}
                    ranges={{
                      good: [50, Infinity],
                      average: [0, 50],
                      bad: [-Infinity, 0],
                    }}
                  />
                  <Box mt={1} />
                  <LabeledList>
                    {DAMAGE_TYPES.map((type) => (
                      <LabeledList.Item key={type.key} label={type.label}>
                        <ProgressBar
                          value={occupant[type.key]}
                          minValue={0}
                          maxValue={occupant.maxHealth}
                          color="bad"
                        />
                      </LabeledList.Item>
                    ))}
                  </LabeledList>
                </>
              ) : (
                <NoticeBox>No patient in pod.</NoticeBox>
              )}
            </Section>
          </Stack.Item>

          {/* Storage & Patient Contents */}
          <Stack.Item grow>
            <Stack fill>
              {/* Stored Items */}
              <Stack.Item grow basis="50%">
                <Section title={`Storage (${storedItems.length}/${maxStorage})`} fill scrollable>
                  {storedItems.length === 0 ? (
                    <NoticeBox>No items loaded.</NoticeBox>
                  ) : (
                    storedItems.map((item) => (
                      <Box key={item.ref} mb={0.5}>
                        <Button
                          fluid
                          icon={item.isOrgan ? 'heart' : 'microchip'}
                          content={item.name}
                          disabled={!hasAccess || !!operating}
                          tooltip="Queue insertion"
                          onClick={() => act('queue_add', { ref: item.ref })}
                        />
                        <Button
                          icon="eject"
                          disabled={!hasAccess || !!operating}
                          tooltip="Eject"
                          onClick={() => act('eject_item', { ref: item.ref })}
                        />
                      </Box>
                    ))
                  )}
                </Section>
              </Stack.Item>

              {/* Patient Contents — organs & implants for removal */}
              <Stack.Item grow basis="50%">
                <Section title="Patient Contents" fill scrollable>
                  {!occupant ? (
                    <NoticeBox>No patient in pod.</NoticeBox>
                  ) : patientOrgans.length === 0 &&
                    patientImplants.length === 0 ? (
                    <NoticeBox>No organs or implants detected.</NoticeBox>
                  ) : (
                    <>
                      {patientOrgans.map((item) => (
                        <Box key={item.ref} mb={0.5}>
                          <Button
                            fluid
                            icon="heart"
                            content={item.name}
                            disabled={!hasAccess || !!operating}
                            tooltip="Queue removal"
                            onClick={() =>
                              act('queue_add_removal', { ref: item.ref })
                            }
                          />
                        </Box>
                      ))}
                      {patientImplants.map((item) => (
                        <Box key={item.ref} mb={0.5}>
                          <Button
                            fluid
                            icon="microchip"
                            content={item.name}
                            disabled={!hasAccess || !!operating}
                            tooltip="Queue removal"
                            onClick={() =>
                              act('queue_add_removal', { ref: item.ref })
                            }
                          />
                        </Box>
                      ))}
                    </>
                  )}
                </Section>
              </Stack.Item>
            </Stack>
          </Stack.Item>

          {/* Procedure Queue */}
          <Stack.Item>
            <Section
              title={`Procedure Queue (${procedureTime}s per step)`}
              scrollable
              buttons={
                <Button
                  icon="play"
                  content="Start"
                  color="good"
                  disabled={
                    !hasAccess ||
                    !!operating ||
                    !occupant ||
                    queue.length === 0
                  }
                  onClick={() => act('start')}
                />
              }
            >
              {operating ? (
                <NoticeBox info>Procedures in progress...</NoticeBox>
              ) : queue.length === 0 ? (
                <NoticeBox>Queue is empty.</NoticeBox>
              ) : (
                queue.map((item, index) => (
                  <Box key={item.ref} mb={0.5}>
                    <Button
                      fluid
                      icon={
                        item.action === 'remove'
                          ? 'minus-circle'
                          : item.isOrgan
                            ? 'heart'
                            : 'microchip'
                      }
                      color={item.action === 'remove' ? 'bad' : undefined}
                      content={`${index + 1}. ${item.action === 'remove' ? 'Remove' : 'Insert'}: ${item.name}`}
                      onClick={() =>
                        act('queue_remove', { ref: item.ref })
                      }
                      tooltip="Remove from queue"
                      disabled={!!operating}
                    />
                  </Box>
                ))
              )}
            </Section>
          </Stack.Item>

          {/* Access Warning */}
          {!hasAccess && (
            <Stack.Item>
              <NoticeBox danger>
                Access denied. Interdyne authorization required.
              </NoticeBox>
            </Stack.Item>
          )}
        </Stack>
      </Window.Content>
    </Window>
  );
}
