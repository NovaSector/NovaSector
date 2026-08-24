import { useState } from 'react';
import {
  Button,
  ColorBox,
  Input,
  LabeledList,
  NoticeBox,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type SupplyEntry = {
  name: string;
  category: string;
  desc: string | null;
  contents: string;
  needs_approval: boolean;
};

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
  supply_cooldown: number;
  catalogue: SupplyEntry[];
};

const BRIGHTNESS_LABELS = ['Out', 'Dim', 'Normal', 'Bright'];

export const HomeConsole = (props) => {
  const { data } = useBackend<Data>();
  const { door_hung } = data;
  const [tab, setTab] = useState<'residence' | 'supplies'>('residence');

  return (
    <Window title="Domicile Registry Console" width={520} height={560}>
      <Window.Content scrollable>
        <Tabs fluid>
          <Tabs.Tab
            icon="house"
            selected={tab === 'residence'}
            onClick={() => setTab('residence')}
          >
            Residence
          </Tabs.Tab>
          <Tabs.Tab
            icon="boxes-stacked"
            selected={tab === 'supplies'}
            onClick={() => setTab('supplies')}
          >
            Requisitions
          </Tabs.Tab>
        </Tabs>
        {tab === 'residence' ? (
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
        ) : (
          <Requisitions />
        )}
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

/** The catalogue, one category at a time, plus a written request for anything it doesn't carry. */
const Requisitions = (props) => {
  const { act, data } = useBackend<Data>();
  const { catalogue, supply_cooldown } = data;
  const [written, setWritten] = useState('');

  const onCooldown = supply_cooldown > 0;
  // Order of first appearance, which is the order the catalogue was sorted into server-side.
  const categories = [...new Set(catalogue.map((entry) => entry.category))];
  const [category, setCategory] = useState(categories[0]);
  // A window can outlive the category it was left on, so never trust the stored one blindly.
  const shown = categories.includes(category) ? category : categories[0];

  return (
    <Stack fill vertical>
      <Stack.Item>
        <NoticeBox color={onCooldown ? 'average' : 'good'}>
          {onCooldown
            ? `The requisition line is busy for another ${Math.ceil(supply_cooldown)}s.`
            : 'The requisition line is open.'}
        </NoticeBox>
      </Stack.Item>
      <Stack.Item>
        <NoticeBox>
          Deliveries belong to the residence and cannot be carried out of it.
          Anything past the basics goes to staff for approval first.
        </NoticeBox>
      </Stack.Item>
      <Stack.Item>
        <Tabs fluid>
          {categories.map((entry) => (
            <Tabs.Tab
              key={entry}
              selected={entry === shown}
              onClick={() => setCategory(entry)}
            >
              {entry}
            </Tabs.Tab>
          ))}
        </Tabs>
      </Stack.Item>
      <Stack.Item>
        <Section title={shown}>
          {catalogue
            .filter((entry) => entry.category === shown)
            .map((entry) => (
              <Stack key={entry.name} align="center" mb={0.5}>
                <Stack.Item grow>
                  {entry.name}
                  {!!entry.needs_approval && (
                    <Button.Checkbox
                      checked
                      disabled
                      ml={1}
                      tooltip="Needs staff approval"
                    >
                      Approval
                    </Button.Checkbox>
                  )}
                  <br />
                  <span style={{ opacity: 0.7 }}>
                    {entry.desc ? `${entry.desc} — ` : ''}
                    {entry.contents}
                  </span>
                </Stack.Item>
                <Stack.Item>
                  <Button
                    icon="rocket"
                    disabled={onCooldown}
                    onClick={() => act('requisition', { name: entry.name })}
                  >
                    Request
                  </Button>
                </Stack.Item>
              </Stack>
            ))}
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section title="Written Request">
          <Stack align="center">
            <Stack.Item grow>
              <Input
                fluid
                placeholder="Something the catalogue doesn't carry…"
                value={written}
                onChange={setWritten}
              />
            </Stack.Item>
            <Stack.Item>
              <Button
                icon="paper-plane"
                disabled={onCooldown || !written}
                onClick={() => {
                  act('written_requisition', { text: written });
                  setWritten('');
                }}
              >
                Send
              </Button>
            </Stack.Item>
          </Stack>
        </Section>
      </Stack.Item>
    </Stack>
  );
};
