import { useState } from 'react';
import {
  Button,
  Image,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';

import { resolveAsset } from '../assets';
import { useBackend } from '../backend';
import { Window } from '../layouts';

type Starter = {
  name: string;
  blurb: string;
  size: string;
};

type Home = {
  slot: number;
  /** The owner's name for it if they gave one, else the plan it grew from. */
  name: string;
  named: boolean;
  starter: string | null;
  last_saved: string | null;
  object_count: number | null;
  preview_asset: string | null;
};

type Host = {
  /** A mob ref, not a ckey — the backend resolves it. Players never see accounts. */
  ref: string;
  name: string;
};

type Data = {
  enabled: boolean;
  starters: Starter[];
  homes: Home[];
  max_homes: number;
  loaded_slots: number[];
  hosts: Host[];
};

/** What the right-hand pane is showing: one of the player's homes, the plan picker, or visiting. */
type Pane = number | 'new' | 'visiting';

const CLOSED_ECONOMY_WARNING = `Your own belongings come and go with you. Anything that
is part of a residence itself stays in it — the front door will take it back off you
on the way out, however you have packed it.`;

export const PlayerHome = (props) => {
  const { data } = useBackend<Data>();
  const { enabled, homes, max_homes, hosts } = data;
  const [picked, setPicked] = useState<Pane | null>(null);

  const canClaim = homes.length < max_homes;
  // Whatever was picked can vanish under the window — a demolished home, or a claim that just
  // used the last free slot. Fall back rather than showing an empty pane.
  const pickedIsValid =
    picked === 'visiting' ||
    (picked === 'new' && canClaim) ||
    homes.some((home) => home.slot === picked);
  const pane: Pane = pickedIsValid
    ? (picked as Pane)
    : homes.length
      ? homes[0].slot
      : 'new';
  const selectedHome = homes.find((home) => home.slot === pane);

  return (
    <Window title="Domicile Registry" width={620} height={600}>
      <Window.Content>
        {!enabled ? (
          <NoticeBox color="bad">
            The registry is offline. No residences can be reached.
          </NoticeBox>
        ) : (
          <Stack fill>
            <Stack.Item width="190px">
              <Section
                fill
                scrollable
                title={`Residences (${homes.length}/${max_homes})`}
              >
                <Tabs vertical>
                  {homes.map((home) => (
                    <Tabs.Tab
                      key={home.slot}
                      icon="house"
                      selected={pane === home.slot}
                      onClick={() => setPicked(home.slot)}
                    >
                      {home.name}
                    </Tabs.Tab>
                  ))}
                  {canClaim && (
                    <Tabs.Tab
                      icon="plus"
                      selected={pane === 'new'}
                      onClick={() => setPicked('new')}
                    >
                      Claim a new plot
                    </Tabs.Tab>
                  )}
                  {/* Deliberately not gated on having a residence — you do not
                      need one of your own to be invited into somebody else's. */}
                  <Tabs.Tab
                    icon="hand-fist"
                    selected={pane === 'visiting'}
                    onClick={() => setPicked('visiting')}
                  >
                    Visiting ({hosts.length})
                  </Tabs.Tab>
                </Tabs>
              </Section>
            </Stack.Item>
            <Stack.Item grow>
              {pane === 'visiting' ? (
                <Visiting />
              ) : selectedHome ? (
                <ExistingHome home={selectedHome} />
              ) : (
                <ClaimPlot />
              )}
            </Stack.Item>
          </Stack>
        )}
      </Window.Content>
    </Window>
  );
};

/** One of the player's residences: enter it, name it, or tear it down. */
const ExistingHome = (props: { home: Home }) => {
  const { act, data } = useBackend<Data>();
  const { home } = props;
  const loaded = data.loaded_slots.includes(home.slot);

  return (
    <Section fill scrollable title={home.name}>
      <Stack vertical>
        <Stack.Item>
          <Button
            fluid
            icon="door-open"
            color="good"
            lineHeight={3}
            fontSize="120%"
            textAlign="center"
            onClick={() => act('enter', { slot: home.slot })}
          >
            Step Inside
          </Button>
        </Stack.Item>
        <Stack.Item>
          {home.preview_asset ? (
            <Image
              width="100%"
              src={resolveAsset(home.preview_asset)}
              style={{ imageRendering: 'pixelated' }}
            />
          ) : (
            <NoticeBox>
              No survey on file. One is taken every time you save.
            </NoticeBox>
          )}
        </Stack.Item>
        <Stack.Item>
          <LabeledList>
            <LabeledList.Item label="Last saved">
              {home.last_saved || 'Never — nothing you change is kept yet.'}
            </LabeledList.Item>
            <LabeledList.Item label="On record">
              {home.object_count
                ? `${home.object_count} objects`
                : 'Nothing catalogued'}
            </LabeledList.Item>
            <LabeledList.Item label="Original plan">
              {home.starter || 'Unknown'}
            </LabeledList.Item>
            <LabeledList.Item label="Status">
              {loaded ? 'Unfolded and waiting' : 'Filed away'}
            </LabeledList.Item>
          </LabeledList>
        </Stack.Item>
        <Stack.Item>
          <Button
            fluid
            icon="pen"
            textAlign="center"
            onClick={() => act('rename', { slot: home.slot })}
          >
            {home.named ? 'Rename' : 'Give it a name'}
          </Button>
        </Stack.Item>
        <Stack.Item>
          <NoticeBox color="average">{CLOSED_ECONOMY_WARNING}</NoticeBox>
        </Stack.Item>
        <Stack.Item>
          <Section title="Danger Zone">
            <Button
              fluid
              icon="trash"
              color="bad"
              textAlign="center"
              onClick={() => act('reset', { slot: home.slot })}
            >
              Demolish this residence
            </Button>
          </Section>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

/** Pick the plan a new residence grows from. It goes in the account's next free slot. */
const ClaimPlot = (props) => {
  const { act, data } = useBackend<Data>();
  const { starters, homes } = data;

  return (
    <Section fill scrollable title="Claim a New Plot">
      <Stack vertical>
        <Stack.Item>
          <NoticeBox>
            {homes.length
              ? 'Pick a plan for another residence. Your others are untouched.'
              : 'You have no residence on file.'}{' '}
            You can rearrange it however you like once you are inside, and save
            it from the console by the front door.
          </NoticeBox>
        </Stack.Item>
        <Stack.Item>
          <NoticeBox color="average">{CLOSED_ECONOMY_WARNING}</NoticeBox>
        </Stack.Item>
        {starters.map((starter) => (
          <Stack.Item key={starter.name}>
            <Section
              title={starter.name}
              buttons={
                <Button
                  icon="key"
                  color="good"
                  onClick={() => act('create', { starter: starter.name })}
                >
                  Claim
                </Button>
              }
            >
              {starter.blurb}
              <br />
              <i>{starter.size} tiles</i>
            </Section>
          </Stack.Item>
        ))}
      </Stack>
    </Section>
  );
};

/**
 * Knocking at somebody else's door. Admission is one-time and granted in the moment — there is no
 * standing permission to display, so this is just a list of people and a knocker.
 */
const Visiting = (props) => {
  const { act, data } = useBackend<Data>();
  const { hosts } = data;

  return (
    <Section fill scrollable title="Visiting">
      {hosts.length ? (
        <>
          <NoticeBox mb={1}>
            Knocking asks them to let you in this once. Leave for any reason and
            you will have to knock again.
          </NoticeBox>
          {hosts.map((host) => (
            <Stack key={host.ref} align="center" mb={0.5}>
              <Stack.Item grow>{host.name}</Stack.Item>
              <Stack.Item>
                <Button
                  icon="hand-fist"
                  onClick={() => act('knock', { ref: host.ref })}
                >
                  Knock
                </Button>
              </Stack.Item>
            </Stack>
          ))}
        </>
      ) : (
        <NoticeBox>Nobody is home right now.</NoticeBox>
      )}
    </Section>
  );
};
