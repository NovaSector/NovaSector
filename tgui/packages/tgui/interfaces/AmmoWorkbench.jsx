// THIS IS A NOVA SECTOR UI FILE
import { useState } from 'react';
import {
  Box,
  Button,
  Collapsible,
  Flex,
  NoticeBox,
  NumberInput,
  ProgressBar,
  RoundGauge,
  Section,
  Stack,
  Table,
  Tabs,
  Tooltip,
} from 'tgui-core/components';
import { toTitleCase } from 'tgui-core/string';

import { useBackend, useSharedState } from '../backend';
import { Window } from '../layouts';

export const AmmoWorkbench = (props) => {
  const [tab, setTab] = useSharedState('tab', 1);
  return (
    <Window width={600} height={600} title="Ammunitions Workbench">
      <Window.Content scrollable>
        <Tabs fluid textAlign="center">
          <Tabs.Tab selected={tab === 1} onClick={() => setTab(1)}>
            Ammunition
          </Tabs.Tab>
          <Tabs.Tab selected={tab === 2} onClick={() => setTab(2)}>
            Materials
          </Tabs.Tab>
        </Tabs>
        {tab === 1 && <AmmunitionsTab />}
        {tab === 2 && <MaterialsTab />}
      </Window.Content>
    </Window>
  );
};

export const AmmunitionsTab = (props) => {
  const { act, data } = useBackend();
  const {
    mag_loaded,
    system_busy,
    error,
    error_type,
    mag_name,
    turboBoost,
    current_rounds,
    max_rounds,
    efficiency,
    time,
    caliber,
    datadisk_loaded,
    datadisk_name,
    datadisk_points,
    available_rounds = [],
  } = data;
  return (
    <>
      {!!error && (
        <NoticeBox textAlign="center" color={error_type}>
          {error}
        </NoticeBox>
      )}
      <Section title="Machine Settings">
        <Box inline mr={4}>
          Current Efficiency:{' '}
          <RoundGauge
            value={efficiency}
            minValue={1.6}
            maxValue={1}
            format={() => null}
          />
        </Box>
        <Box>Time Per Round: {time} seconds</Box>
        <Button.Checkbox
          textAlign="right"
          checked={turboBoost}
          onClick={() => act('turboBoost')}
        >
          Overclock
        </Button.Checkbox>
      </Section>
      <Section
        title="Loaded Magazine"
        buttons={
          <>
            {!!mag_loaded && (
              <Box inline mr={2}>
                <ProgressBar
                  value={current_rounds}
                  minValue={0}
                  maxValue={max_rounds}
                />
              </Box>
            )}
            <Button
              icon="eject"
              content="Eject"
              disabled={!mag_loaded}
              onClick={() => act('EjectMag')}
            />
          </>
        }
      >
        {!!mag_loaded && <Box>{mag_name}</Box>}
        {!!mag_loaded && (
          <Box bold textAlign="right">
            {current_rounds} / {max_rounds}
          </Box>
        )}
      </Section>
      <Section title="Available Ammunition Types">
        {!!mag_loaded && (
          <Flex.Item grow={1} basis={0}>
            {available_rounds.map((available_round) => (
              <Box
                key={available_round.name}
                className="candystripe"
                p={1}
                pb={2}
              >
                <Stack.Item>
                  <Tooltip
                    content={available_round.mats_list}
                    position={'right'}
                  >
                    <Button
                      content={available_round.name}
                      disabled={system_busy}
                      onClick={() =>
                        act('FillMagazine', {
                          selected_type: available_round.typepath,
                        })
                      }
                    />
                  </Tooltip>
                </Stack.Item>
              </Box>
            ))}
          </Flex.Item>
        )}
      </Section>
      <Section
        title="Module Management"
        buttons={
          <Button
            icon="eject"
            content="Eject"
            disabled={!datadisk_loaded}
            onClick={() => act('EjectDisk')}
          />
        }
      >
        {!!datadisk_loaded && <Box>Loaded Module: {datadisk_name}</Box>}
        {!!datadisk_loaded && <Box>Points Left: {datadisk_points}</Box>}
        <Collapsible title="Owner's Manual">
          <Section color="label">
            The ammunition workbench, by default, can print basic non-lethal
            ammunition (e.g. rubber bullets, IHDF).
            <br />
            <br />
            License modules can be purchased from Cargo or printed with
            sufficient research, enabling the printing of other ammunition
            variants, such as lethal, armor-piercing, or hollow-point
            ammunition. Each module have a limited number of usage points, with
            different ammunition having different point costs.
            <br />
            <br />
            These modules are <b>reusable</b> and can have their license points
            recharged with <b>authenticators</b>, which are&nbsp;
            <b>much cheaper</b> than individual modules. These can be purchased
            from Cargo or printed from techfabs with the proper technology
            researched.
          </Section>
        </Collapsible>
      </Section>
    </>
  );
};

export const MaterialsTab = (props) => {
  const { act, data } = useBackend();
  const { materials = [] } = data;
  return (
    <Section title="Materials">
      <Table>
        {materials
          .filter((material) => material.amount > 0)
          .map((material) => (
            <MaterialRow
              key={material.id}
              material={material}
              onRelease={(amount) =>
                act('Release', {
                  id: material.id,
                  sheets: amount,
                })
              }
            />
          ))}
      </Table>
    </Section>
  );
};

const MaterialRow = (props) => {
  const { material, onRelease } = props;

  const [amount, setAmount] = useState(1);

  const amountAvailable = Math.floor(material.amount);
  return (
    <Table.Row>
      <Table.Cell>{toTitleCase(material.name)}</Table.Cell>
      <Table.Cell collapsing textAlign="right">
        <Box mr={2} color="label" inline>
          {amountAvailable} sheets
        </Box>
      </Table.Cell>
      <Table.Cell collapsing>
        <NumberInput
          width="32px"
          step={1}
          stepPixelSize={5}
          minValue={1}
          maxValue={50}
          value={amount}
          onChange={(value) => setAmount(value)}
        />
        <Button
          disabled={amountAvailable < 1}
          content="Release"
          onClick={() => onRelease(amount)}
        />
      </Table.Cell>
    </Table.Row>
  );
};
