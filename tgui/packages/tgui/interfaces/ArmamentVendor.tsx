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
  points: [];
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
        <Stack.Item>
          <ArmamentContainer />
        </Stack.Item>
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
  const { data, act } = useBackend<WeaponVendorStockData>();
  const {
    ref,
    name,
    description,
    cost,
    category,
    product,
    buy_limit,
    permit_req,
  } = data;

  return (
    <Section title="Purchasables" scrollable>
      DROPDOWN LIST NEEDED HERE
      {Object.entries(data).map(([category, value], index) => (
        <Collapsible
          key={category}
          inline
          mr="5px"
          className={`ArmamentVendor--${category}`}
        >
          {value} {category}
        </Collapsible>
      ))}
      <Collapsible title="TEST-TITLE (Haha Testicle)">
        Button Content
      </Collapsible>
    </Section>
  );
};
