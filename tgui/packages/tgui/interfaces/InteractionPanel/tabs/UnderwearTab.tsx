// THIS IS A NOVA SECTOR UI FILE
import { Button, NoticeBox, Section, Stack, Table } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { useBackend } from '../../../backend';

type UnderwearConfigEntry = {
  name: string;
  hidden: BooleanLike;
  worn: BooleanLike;
};

type UnderwearConfig = {
  underwear_config: UnderwearConfigEntry[];
};

export const UnderwearTab = () => {
  const { act, data } = useBackend<UnderwearConfig>();
  const { underwear_config = [] } = data;

  const anyHidden = underwear_config.some((slot) => !!slot.hidden);
  const anyShown = underwear_config.some((slot) => !slot.hidden);

  return (
    <Stack fill vertical>
      <NoticeBox>
        {underwear_config.length > 0
          ? 'Configure how your underwear renders.'
          : 'Nothing to configure'}
      </NoticeBox>
      <Stack.Item>
        <Button
          icon="eye"
          disabled={!anyHidden}
          tooltip="Show every underwear slot."
          onClick={() => act('set_all_underwear_visibility', { hidden: 0 })}
        >
          Show all
        </Button>
        <Button
          icon="eye-slash"
          disabled={!anyShown}
          tooltip="Hide every underwear slot."
          onClick={() => act('set_all_underwear_visibility', { hidden: 1 })}
        >
          Hide all
        </Button>
      </Stack.Item>
      <Stack.Item grow>
        <Section scrollable>
          <Table>
            <Table.Row header>
              <Table.Cell />
              <Table.Cell collapsing textAlign="center" color="label" pl={2}>
                Visibility
              </Table.Cell>
            </Table.Row>
            {underwear_config.map((slot) => (
              <Table.Row key={slot.name} className="candystripe">
                <Table.Cell
                  bold
                  verticalAlign="middle"
                  color={slot.worn ? undefined : 'label'}
                >
                  {slot.name}
                </Table.Cell>
                <Table.Cell collapsing textAlign="center" pl={2}>
                  <Button
                    icon="eye"
                    selected={!slot.hidden}
                    tooltip={
                      slot.worn
                        ? `Show your ${slot.name.toLowerCase()}.`
                        : `You aren't wearing any ${slot.name.toLowerCase()}.`
                    }
                    onClick={() =>
                      act('set_underwear_visibility', {
                        slot: slot.name,
                        hidden: 0,
                      })
                    }
                  />
                  <Button
                    icon="eye-slash"
                    selected={!!slot.hidden}
                    tooltip={
                      slot.worn
                        ? `Hide your ${slot.name.toLowerCase()}.`
                        : `You aren't wearing any ${slot.name.toLowerCase()}.`
                    }
                    onClick={() =>
                      act('set_underwear_visibility', {
                        slot: slot.name,
                        hidden: 1,
                      })
                    }
                  />
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
        </Section>
      </Stack.Item>
    </Stack>
  );
};
