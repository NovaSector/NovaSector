import {
  Button,
  ColorBox,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Data = {
  last_saved: string | null;
  saving: boolean;
  door_hung: boolean;
  bolted: boolean;
  brightness: number;
  lamp_color: string;
  gravity: boolean;
  has_backup: boolean;
  max_brightness: number;
};

const BRIGHTNESS_LABELS = ['Out', 'Dim', 'Normal', 'Bright'];

export const HomeConsole = (props) => {
  const { data } = useBackend<Data>();
  const { door_hung } = data;

  return (
    <Window title="Domicile Registry Console" width={400} height={470}>
      <Window.Content scrollable>
        <Stack fill vertical>
          {!door_hung && (
            <Stack.Item>
              <NoticeBox color="bad">
                Your front door is not hung. The registry will not accept a
                record until it is back up.
              </NoticeBox>
            </Stack.Item>
          )}
          <Stack.Item>
            <TheRecord />
          </Stack.Item>
          <Stack.Item>
            <Lighting />
          </Stack.Item>
          <Stack.Item>
            <Fittings />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

/** Saving, restoring, and stepping back out. */
const TheRecord = (props) => {
  const { act, data } = useBackend<Data>();
  const { last_saved, saving, door_hung, has_backup } = data;

  return (
    <Section title="The Record">
      <LabeledList>
        <LabeledList.Item label="Last saved">
          {last_saved ? `${last_saved} UTC` : 'Never'}
        </LabeledList.Item>
      </LabeledList>
      <Button
        fluid
        mt={1}
        icon="floppy-disk"
        color="good"
        lineHeight={2}
        textAlign="center"
        disabled={saving || !door_hung}
        onClick={() => act('save')}
      >
        {saving ? 'Committing…' : 'Commit record'}
      </Button>
      <Button
        fluid
        icon="clock-rotate-left"
        textAlign="center"
        disabled={!has_backup}
        tooltip={has_backup ? undefined : 'No earlier record on file.'}
        onClick={() => act('restore')}
      >
        Restore previous save
      </Button>
      <Button
        fluid
        icon="door-open"
        textAlign="center"
        onClick={() => act('leave')}
      >
        Leave residence
      </Button>
    </Section>
  );
};

/** Brightness steps and bulb colour, applied to every fixture at once. */
const Lighting = (props) => {
  const { act, data } = useBackend<Data>();
  const { brightness, lamp_color, max_brightness } = data;

  const steps: number[] = [];
  for (let i = 0; i <= max_brightness; i++) {
    steps.push(i);
  }

  return (
    <Section title="Lighting">
      <Stack>
        {steps.map((step) => (
          <Stack.Item grow key={step}>
            <Button
              fluid
              textAlign="center"
              selected={brightness === step}
              onClick={() => act('set_brightness', { value: step })}
            >
              {BRIGHTNESS_LABELS[step] ?? step}
            </Button>
          </Stack.Item>
        ))}
      </Stack>
      <Stack mt={1} align="center">
        <Stack.Item>
          <ColorBox color={lamp_color || '#ffffff'} />
        </Stack.Item>
        <Stack.Item grow>
          <Button fluid icon="palette" onClick={() => act('pick_color')}>
            {lamp_color ? `Bulb colour ${lamp_color}` : 'Bulb colour (default)'}
          </Button>
        </Stack.Item>
        {!!lamp_color && (
          <Stack.Item>
            <Button
              icon="rotate-left"
              tooltip="Back to each fixture's own colour"
              onClick={() => act('set_color', { value: '' })}
            />
          </Stack.Item>
        )}
      </Stack>
    </Section>
  );
};

/** The things a player can physically move or switch off. */
const Fittings = (props) => {
  const { act, data } = useBackend<Data>();
  const { door_hung, bolted, gravity } = data;

  return (
    <Section title="Fittings">
      <LabeledList>
        <LabeledList.Item label="Gravity">
          <Button
            icon={gravity ? 'weight-hanging' : 'feather'}
            selected={gravity}
            onClick={() => act('toggle_gravity')}
          >
            {gravity ? 'On' : 'Off'}
          </Button>
        </LabeledList.Item>
        <LabeledList.Item label="Front door">
          <Button
            icon="screwdriver-wrench"
            disabled={!door_hung}
            tooltip={
              door_hung
                ? 'Hands you the door. Use it on any wall to hang it there.'
                : 'Already taken down — hang it on a wall.'
            }
            onClick={() => act('take_down_door')}
          >
            Take down
          </Button>
        </LabeledList.Item>
        <LabeledList.Item label="This console">
          <Button
            icon={bolted ? 'lock' : 'lock-open'}
            selected={bolted}
            tooltip={
              bolted
                ? 'Unbolt it to drag it somewhere else.'
                : 'Drag it into place, then bolt it back down.'
            }
            onClick={() => act('toggle_bolts')}
          >
            {bolted ? 'Bolted down' : 'Unbolted'}
          </Button>
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};
