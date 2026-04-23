// THIS IS A NOVA SECTOR UI FILE
import { useBackend } from 'tgui/backend';
import {
  BlockQuote,
  Box,
  Button,
  Collapsible,
  Stack,
  Table,
} from 'tgui-core/components';
import type { NifPanelData, NifProgramData } from './data';

export function NifProgram(props: { src: NifProgramData }) {
  const { act, data } = useBackend<NifPanelData>();
  const { max_power } = data;
  const { src } = props;

  return (
    <Collapsible
      title={src.name}
      icon={src.ui_icon}
      buttons={
        <Stack>
          <Button.Confirm
            inline
            icon="trash"
            color="red"
            tooltip="Uninstall"
            confirmContent="Uninstall?"
            onClick={() =>
              act('uninstall_nifsoft', {
                nifsoft_to_remove: src.reference,
              })
            }
          />
          <Button
            inline
            icon={src.active ? 'pause' : 'play'}
            color={src.active ? 'yellow' : 'green'}
            tooltip={src.active ? 'De-activate' : 'Activate'}
            onClick={() =>
              act('activate_nifsoft', {
                activated_nifsoft: src.reference,
              })
            }
          />
        </Stack>
      }
    >
      <Table mb="5px">
        <Table.Row>
          <Table.Cell>
            <Button
              icon={!src.activation_cost ? 'check' : 'plug'}
              color="yellow"
              tooltip="What percent of the power is used when activating the NIFSoft."
              disabled={!src.activation_cost}
              mr="5px"
            />
            {!src.activation_cost
              ? 'No activation cost'
              : `${+(src.activation_cost / max_power) * 100}% per activation`}
          </Table.Cell>
          <Table.Cell>
            <Button
              icon={src.active_cost ? 'battery-half' : 'battery-empty'}
              color="orange"
              tooltip="The power that the NIFSoft uses while active."
              disabled={!src.active_cost}
              mr="5px"
            />
            {!src.active_cost
              ? 'No active drain'
              : `${(src.active_cost / max_power) * 100}% consumed while active`}
          </Table.Cell>
          <Table.Cell>
            <Button
              icon="power-off"
              color={src.active ? 'green' : 'red'}
              disabled={!src.active_mode}
              tooltip="Shows whether or not a program is currently active or not."
              mr="5px"
            />
            {src.active ? 'Active' : 'Not active'}
          </Table.Cell>
        </Table.Row>
      </Table>
      <BlockQuote preserveWhitespace>{src.desc}</BlockQuote>
      {!!src.able_to_keep && (
        <Button
          icon="floppy-disk"
          color={src.keep_installed ? 'green' : 'red'}
          tooltip="Toggle if the NIFSoft will stay saved between shifts"
          onClick={() =>
            act('toggle_keeping_nifsoft', {
              nifsoft_to_keep: src.reference,
            })
          }
        >
          {src.keep_installed
            ? 'The NIFSoft will stay saved'
            : "The NIFSoft won't stay saved"}
        </Button>
      )}
    </Collapsible>
  );
}
