// THIS IS A NOVA SECTOR UI FILE
import type {
  Feature,

} from '../../base';

import { FeatureIconnedDropdownInput, type FeatureWithIcons, } from '../../dropdowns';

export const lunchbox_design: FeatureWithIcons<string> = {
  name: 'Lunchbox Design',
  description: "What design of the lunchbox would you like?",
  component: FeatureIconnedDropdownInput,
};

export const lunchbox_meal_choice: FeatureWithIcons<string> = {
  name: 'Meal Choice',
  description: "What meal would you like inside the lunchbox?",
  component: FeatureIconnedDropdownInput,
};

export const lunchbox_first_snack_choice: FeatureWithIcons<string> = {
  name: 'First Snack Choice',
  description: "What snack would you like inside the lunchbox",
  component: FeatureIconnedDropdownInput,
};

export const lunchbox_second_snack_choice: FeatureWithIcons<string> = {
  name: 'Second Snack Choice',
  description: "What snack would you like inside the lunchbox",
  component: FeatureIconnedDropdownInput,
};

export const lunchbox_drink_choice: FeatureWithIcons<string> = {
  name: 'Drink Choice',
  description: "What drink would you like inside your lunchbox?",
  component: FeatureIconnedDropdownInput,
};

export const lunchbox_desert_choice: Feature<string> = {
  name: 'Dessert Choice',
  description: "What drink would you like inside your lunchbox?",
  component: FeatureIconnedDropdownInput,
};
