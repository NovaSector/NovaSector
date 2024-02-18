import { useBackend } from '../backend';
import { Button, LabeledList, NoticeBox, Section } from '../components';
import { Window } from '../layouts';

export const DeployableTurret = (props) => {
  const { act, data } = useBackend();
  const {
    silicon_user,
    locked,
    on,
    fire_at_humans,
    target_factions,
    manual_target_acquisition_toggle,
    fire_at_cyborgs,
    manual_control,
    allow_manual_control,
    lasertag_turret,
  } = data;
  return (
    <Window width={310} height={lasertag_turret ? 110 : 292}>
      <Window.Content>
        <NoticeBox>
          Swipe an ID card to {locked ? 'unlock' : 'lock'} this interface.
        </NoticeBox>
        <>
          <Section>
            <LabeledList>
              <LabeledList.Item
                label="Status"
                buttons={
                  !lasertag_turret &&
                  (!!allow_manual_control ||
                    (!!manual_control && !!silicon_user)) && (
                    <Button
                      icon={manual_control ? 'wifi' : 'terminal'}
                      content={
                        manual_control
                          ? 'Remotely Controlled'
                          : 'Manual Control'
                      }
                      disabled={manual_control}
                      color="bad"
                      onClick={() => act('manual')}
                    />
                  )
                }
              >
                <Button
                  icon={on ? 'power-off' : 'times'}
                  content={on ? 'On' : 'Off'}
                  selected={on}
                  disabled={locked}
                  onClick={() => act('power')}
                />
              </LabeledList.Item>
            </LabeledList>
          </Section>
          {!lasertag_turret && (
            <Section title="Target Settings">
              <Button.Checkbox
                fluid
                checked={manual_target_acquisition_toggle}
                content="Allow Manual Targeting"
                disabled={locked}
                onClick={() => act('togglemanual')}
              />
              <Button.Checkbox
                fluid
                checked={target_factions}
                content="Ignore Factions"
                disabled={locked}
                onClick={() => act('checkfactions')}
              />
              <Button.Checkbox
                fluid
                checked={fire_at_humans}
                content="Humans"
                disabled={locked}
                onClick={() => act('checkhumans')}
              />
              <Button.Checkbox
                fluid
                checked={fire_at_cyborgs}
                content="Cyborgs"
                disabled={locked}
                onClick={() => act('shootborgs')}
              />
            </Section>
          )}
        </>
      </Window.Content>
    </Window>
  );
};
