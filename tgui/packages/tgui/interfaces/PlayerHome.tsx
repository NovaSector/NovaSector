import {
  Button,
  Image,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
} from 'tgui-core/components';

import { resolveAsset } from '../assets';
import { useBackend } from '../backend';
import { Window } from '../layouts';

type Starter = {
  name: string;
  blurb: string;
  size: string;
};

type Host = {
  /** A mob ref, not a ckey — the backend resolves it. Players never see accounts. */
  ref: string;
  name: string;
};

type Data = {
  preview_asset: string | null;
  enabled: boolean;
  has_home: boolean;
  loaded: boolean;
  last_saved: string | null;
  object_count: number | null;
  starter: string | null;
  starters: Starter[];
  hosts: Host[];
};

const CLOSED_ECONOMY_WARNING = `Your own belongings come and go with you. Anything that
is part of the residence itself stays in it — the front door will take it back off you
on the way out, however you have packed it.`;

export const PlayerHome = (props) => {
  const { data } = useBackend<Data>();
  const { enabled, has_home } = data;

  return (
    <Window title="Domicile Registry" width={420} height={600}>
      <Window.Content scrollable>
        {!enabled ? (
          <NoticeBox color="bad">
            The registry is offline. No residences can be reached.
          </NoticeBox>
        ) : (
          <>
            {has_home ? <ExistingHome /> : <FirstTimeSetup />}
            {/* Deliberately outside the branch — you do not need a residence of
                your own to be invited into somebody else's. */}
            <Visiting />
          </>
        )}
      </Window.Content>
    </Window>
  );
};

/** Shown once the player has a residence on file: enter it, or tear it down. */
const ExistingHome = (props) => {
  const { act, data } = useBackend<Data>();
  const { loaded, last_saved, object_count, starter, preview_asset } = data;

  // Not `fill`, and nothing `grow`s: this used to be the only thing in the window, and once the
  // visiting list was added below it, a filling stack ate the viewport and pushed the entry button
  // off the bottom. Everything now flows top-down and scrolls, with the button that matters first.
  return (
    <Stack vertical>
      <Stack.Item>
        <Button
          fluid
          icon="door-open"
          color="good"
          lineHeight={3}
          fontSize="120%"
          textAlign="center"
          onClick={() => act('enter')}
        >
          Step Inside
        </Button>
      </Stack.Item>
      <Stack.Item>
        <Section title="Your Residence">
          {preview_asset ? (
            <Image
              mb={1}
              width="100%"
              src={resolveAsset(preview_asset)}
              style={{ imageRendering: 'pixelated' }}
            />
          ) : (
            <NoticeBox mb={1}>
              No survey on file. One is taken every time you save.
            </NoticeBox>
          )}
          <LabeledList>
            <LabeledList.Item label="Last saved">
              {last_saved || 'Never — nothing you change is kept yet.'}
            </LabeledList.Item>
            <LabeledList.Item label="On record">
              {object_count ? `${object_count} objects` : 'Nothing catalogued'}
            </LabeledList.Item>
            <LabeledList.Item label="Original plan">
              {starter || 'Unknown'}
            </LabeledList.Item>
            <LabeledList.Item label="Status">
              {loaded ? 'Unfolded and waiting' : 'Filed away'}
            </LabeledList.Item>
          </LabeledList>
        </Section>
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
            onClick={() => act('reset')}
          >
            Demolish and start over
          </Button>
        </Section>
      </Stack.Item>
    </Stack>
  );
};

/** Shown to a player who has never had a residence: pick the plan it grows from. */
const FirstTimeSetup = (props) => {
  const { act, data } = useBackend<Data>();
  const { starters } = data;

  return (
    <Stack vertical>
      <Stack.Item>
        <NoticeBox>
          You have no residence on file. Pick a plan to build one from — you can
          rearrange it however you like once you are inside, and save it from the
          console by the front door.
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
    <Section title="Visiting">
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
