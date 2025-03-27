// THIS IS A NOVA SECTOR UI FILE
import {
  Box,
  Button,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
} from 'tgui-core/components';
import { BooleanLike } from 'tgui-core/react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type ReactorInfo = {
  venting: BooleanLike;
  vent_dir: BooleanLike;
  active: BooleanLike;
  safety: BooleanLike;
  overclocked: BooleanLike;
  criticality: number;
  health_percent: number;
  max_power_generation: number;
  safeties_max_power_generation: number;
  raw_last_power_output: number;
  last_power_output: string;
  consuming: string;
  raw_consuming: number;
  rod: BooleanLike;
  rod_mix_pressure: number;
  rod_pressure_limit: number;
  rod_mix_temperature: number;
  rod_trit_moles: number;

  // Misc
  jammed: BooleanLike;
  meltdown: BooleanLike;
};

export const RBMK2 = (props) => {
  const { act, data } = useBackend<ReactorInfo>();
  return (
    <Window width={350} height={710}>
      <Window.Content>
        <Section textAlign="center" title="Status">
          <LabeledList>
            <LabeledList.Item label="Activity">
              <NoticeBox danger textAlign="center" backgroundColor={data.active ? 'good' : 'bad'}>
                {data.active ? 'ONLINE' : 'OFFLINE'}
              </NoticeBox>
            </LabeledList.Item>
            <LabeledList.Item label="Reaction">
              <NoticeBox danger textAlign="center" backgroundColor={data.active ? 'bad' : 'good'}>
                {data.meltdown ? 'MELTDOWN' : 'STABLE'}
              </NoticeBox>
            </LabeledList.Item>
            <LabeledList.Item label="Clearance">
              <NoticeBox danger textAlign="center" backgroundColor={data.active ? 'bad' : 'good'}>
                {data.jammed ? 'JAMMED' : 'SAFE'}
              </NoticeBox>
            </LabeledList.Item>
            <LabeledList.Divider size={1}></LabeledList.Divider>
            <LabeledList.Item label="Power Generation">
              <ProgressBar
                value={data.raw_last_power_output}
                minValue={0}
                maxValue={data.safeties_max_power_generation}
                ranges={{
                  maroon: [(data.max_power_generation * 10), Infinity],
                  bad: [data.max_power_generation, (data.max_power_generation * 10)],
                  yellow: [data.safeties_max_power_generation, data.max_power_generation],
                  good: [0, data.safeties_max_power_generation],
                }}
              >
                {data.last_power_output}
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Rod Pressure">
            <ProgressBar
                value={data.rod_mix_pressure}
                minValue={0}
                maxValue={data.rod_pressure_limit}
                ranges={{
                  maroon: [(data.rod_pressure_limit * 2), Infinity],
                  bad: [data.rod_pressure_limit, (data.rod_pressure_limit * 2)],
                  orange: [(data.rod_pressure_limit * 0.75), data.rod_pressure_limit],
                  yellow: [(data.rod_pressure_limit * 0.5), (data.rod_pressure_limit * 0.75)],
                  good: [-Infinity, (data.rod_pressure_limit * 0.5)],
                }}
              >
                {data.rod_mix_pressure} kPa
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Rod Temperature">
            <ProgressBar
                value={data.rod_mix_temperature}
                // Thermomachine/gas meter colors + maroon.
                ranges={{
                  maroon: [2000, Infinity],
                  red: [700, 2000],
                  orange: [460, 700],
                  yellow: [340, 460],
                  good: [200, 340],
                  cyan: [120, 200],
                  blue: [60, 120],
                  violet: [-Infinity, 60]
                }}
              >
                {data.rod_mix_temperature} K
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Remaining Fuel">
              <ProgressBar // Changes color based on rate of consumption while giving you a total reading.
                value={data.rod_trit_moles}
                minValue={0}
                maxValue={9}
                ranges={{
                  // Assuming a sane operator, 9 moles can produce 1 MW for 3 hours. We have calculated for 5, 10, and 15 minutes to give colored warnings.
                  bad: [-Infinity, (data.raw_consuming * 300)],
                  orange: [(data.raw_consuming * 300), (data.raw_consuming * 600)],
                  yellow: [(data.raw_consuming * 600), (data.raw_consuming * 900)],
                  good: [(data.raw_consuming * 900), Infinity],
                }}
              >
                {data.rod_trit_moles} Moles
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Tritium Usage">
              {data.consuming} μmol/s
            </LabeledList.Item>
            <LabeledList.Item label="Criticality">
            <ProgressBar
                value={data.criticality}
                minValue={0}
                maxValue={100}
                ranges={{
                  maroon: [100, Infinity],
                  bad: [75, 100],
                  orange: [50, 75],
                  yellow: [25, 50],
                  good: [-Infinity, 25],
                }}
              >
                {data.criticality}%
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Integrity">
            <ProgressBar
                value={data.health_percent}
                minValue={0}
                maxValue={100}
                ranges={{
                  good: [80, Infinity],
                  yellow: [50, 80],
                  orange: [25, 50],
                  bad: [5, 25],
                  maroon: [-Infinity, 5],
                }}
              >
                {data.health_percent}%
              </ProgressBar>
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section title="Controls" textAlign="center">
          <LabeledList>
            <Button.Confirm
              tooltip="Reactor Activation/Deactivation Button"
              textAlign="center"
              width="100%"
              icon="fa-power-off"
              confirmContent="Are you sure?"
              //selected={data.active}
              color={data.active ? 'yellow' : 'good'}
              onClick={() => act('activate')}
            >
              {data.active ? 'Deactivate' : 'Activate'}
            </Button.Confirm>
            {data.rod ? (
              <Button.Confirm
                tooltip="Fuel Rod Ejection Button"
                textAlign="center"
                width="100%"
                icon="fa-eject"
                color="bad"
                onClick={() => act('eject')}
              >
                Eject Fuel Rod
              </Button.Confirm>
            ) : (
              <NoticeBox danger textAlign="center">
                No control rod to eject
              </NoticeBox>
            )}
          </LabeledList>
        <Section title="Vent Controls" textAlign="center">NOTICE: The vents must be off to change directions. This is a cost saving measure, don't print this part.</Section>
          <LabeledList>
            <LabeledList.Item
              label="Vent Power"
              buttons={
                <>
                  <Box
                    inline
                    mx={2}
                    color={data.venting ? 'good' : 'bad'}
                  >
                    {data.venting ? 'ONLINE' : 'OFFLINE'}
                  </Box>
                  <Button.Confirm
                    tooltip="Toggle the vents On/Off."
                    textAlign="center"
                    icon="fa-fan"
                    color={data.venting ? 'bad' : 'good'}
                    onClick={() => act('venttoggle')}
                  >TOGGLE</Button.Confirm>
                </>
              }
            >
            </LabeledList.Item>
            <LabeledList.Item
              label="Vent Direction"
              buttons={
                <>
                  <Box
                    inline
                    mx={5.68}
                    color={data.vent_dir ? 'bad' : 'good'}
                  >
                    {data.vent_dir ? 'PULLING' : 'PUSHING'}
                  </Box>
                  <Button
                    tooltip="Sets the vents to vacuum from the surrounding environment into the internal RBMK2 chamber."
                    icon="fa-clock-rotate-left"
                    disabled={data.venting}
                    color={data.vent_dir ? 'yellow' : 'blue'}
                    //content="PULL"
                    onClick={() => act('ventpull')}
                  />
                  <Button
                    tooltip="Sets the vents to exhaust their contents into the surrounding environment."
                    icon="fa-clock-rotate-left fa-flip-horizontal"
                    disabled={data.venting}
                    color={data.vent_dir ? 'blue' : 'good'}
                    //content="PUSH"
                    onClick={() => act('ventpush')}
                  />
                </>
              }
            >
            </LabeledList.Item>
          </LabeledList>
        <Section title="Adv. Controls" textAlign="center">WARNING: Settings within this section may explosively void your warranty.</Section>
          <LabeledList>
            <LabeledList.Item
                label="Safeties"
                buttons={
                  <>
                    <Box
                      inline
                      mx={2}
                      color={data.safety ? 'good' : 'bad'}
                    >
                      {data.safety ? 'ONLINE' : 'OFFLINE'}
                    </Box>
                    <Button.Confirm
                      tooltip="DANGER: Toggle safeties on/off"
                      //textAlign="center"
                      //width="100%"
                      icon="fa-helmet-safety"
                      color={data.safety ? 'bad' : 'good'}
                      onClick={() => act('safetytoggle')}
                      //{data.safety ? 'Toggle OFF' : 'Toggle ON'}
                    >
                      TOGGLE
                    </Button.Confirm>
                  </>
                }
            >
            </LabeledList.Item>
            <LabeledList.Item
              label="Overclock"
              buttons={
                <>
                  <Box
                    inline
                    mx={2}
                    color={data.overclocked ? 'good' : 'bad'}
                  >
                    {data.overclocked ? 'ONLINE' : 'OFFLINE'}
                  </Box>
                  <Button.Confirm
                    tooltip="DANGER: Toggle overclock on/off"
                    //textAlign="center"
                    //width="100%"
                    icon="exclamation-triangle"
                    color={data.overclocked ? 'yellow' : 'good'}
                    onClick={() => act('overclocktoggle')}
                    //{data.overclocked ? 'Toggle OFF' : 'Toggle ON'}
                  >
                    TOGGLE
                  </Button.Confirm>
                </>
              }
            >
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Window.Content>
    </Window>
  );
};
