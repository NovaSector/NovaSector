// THIS IS A NOVA SECTOR UI FILE
import { Button, Collapsible, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

export const ArmamentVendor = (props) => {
  const { act, data } = useBackend();
  const { equipment_stock = [], card_inserted, card_points, card_name } = data;
  return (
    <Window>
      <Window.Content>
        <Stack fill>
          <Stack.Item>
            <Section
              fill
              title="SECTIONTEST"
              buttons={<Button>Send shuttle</Button>}
            >
              <Collapsible title="ASS" color="red">
                <Button
                  textAlign="center"
                  width="100%"
                  // </Collapsible>disabled={
                  // item.cost > card_points || item.purchased >= item.quantity
                  // }
                  onClick={() =>
                    act('equip_item', {
                      // armament_ref: item.ref,
                    })
                  }
                >
                  buymottherfucker
                </Button>
                <Button>Button 2</Button>
                <Button>Button 3</Button>
              </Collapsible>
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
