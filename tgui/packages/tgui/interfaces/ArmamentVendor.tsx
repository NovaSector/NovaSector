// THIS IS A NOVA SECTOR UI FILE
import {
  Box,
  Collapsible,
  LabeledList,
  Section,
  Stack,
} from 'tgui-core/components';
import { pluralize } from 'tgui-core/string';

import { useBackend } from '../backend';
import { Window } from '../layouts';
interface WeaponVendorData {
  name: string;
  desc: string;
  points: {
    primary: number;
    secondary: number;
    uniform: number;
    equipment: number;
    utilities: number;
    special: number;
  };
  stock: WeaponVendorStockData[];
}

type WeaponVendorStockData = {
  ref: string;
  name: string;
  description: string;
  cost: number;
  category: string;
  product: string;
  buy_limit: number;
  permit_req: boolean;
};

// For those wanting to learn TSX, Take a look at my code or use https://tgstation.github.io/tgui-core

/*
 TODO
 Make Points Content Piece of UI (Keeps track of how many points are loaded)
 Make Collapsible categories that contain its product within it. Likely use .map whatever that does. Just see Vending.tsx and QuantumConsole.tsx

*/

export const ArmamentVendor = (props) => {
  const { data } = useBackend<WeaponVendorData>();
  return (
    <Window width={550} height={700}>
      <Window.Content>
        <Stack.Item>
          <PointsContent />
        </Stack.Item>
        <Stack.Item>aass</Stack.Item>
      </Window.Content>
    </Window>
  );
};

export const PointsContent = (props) => {
  const { data } = useBackend<WeaponVendorData>();

  return (
    <Section title="Point Balance">
      <LabeledList>
        <LabeledList.Item>
          {Object.entries(data.points).map(([name, value], index) => (
            <Box
              key={name}
              inline
              mr="5px"
              className={`ArmamentVendor--${name}`}
            >
              {value} {name} {pluralize('point', value)}
              {index + 1 !== Object.keys(value).length ? ', ' : ''}
            </Box>
          ))}
        </LabeledList.Item>
      </LabeledList>
    </Section>
  );
};

// Container should be a collapsible with its key being a category

export const ArmamentContainer = (props) => {
  const { data } = useBackend<WeaponVendorStockData>();

  return (
    <Stack>
      <Stack.Item grow={1}>
        <Section fill scrollable title="Equipment">
          {Object.entries(data.category).map(([name, value]) => (
            <Collapsible key={value} title={name} color="red">
              ass
            </Collapsible>
          ))}
        </Section>
      </Stack.Item>
    </Stack>
  );
};
