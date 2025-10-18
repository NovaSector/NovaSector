// THIS IS A NOVA SECTOR UI FILE
import {
  Feature,
  FeatureChoiced,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const lunchbox_design: FeatureChoiced = {
  name: 'Lunchbox Design',
  description: "What design of the lunchbox would you like?",
  component: FeatureDropdownInput,
};

export const lunchbox_meal_choice: FeatureChoiced = {
  name: 'Meal Choice',
  description: "What meal would you like inside the lunchbox?",
  component: FeatureDropdownInput,
};

export const lunchbox_first_snack_choice: Feature<string> = {
  name: 'First Snack Choice',
  description: "What snack would you like inside the lunchbox",
  component: FeatureDropdownInput,
};

export const lunchbox_second_snack_choice: Feature<string> = {
  name: 'Second Snack Choice',
  description: "What snack would you like inside the lunchbox",
  component: FeatureDropdownInput,
};

export const lunchbox_drink_choice: Feature<string> = {
  name: 'Drink Choice',
  description: "What drink would you like inside your lunchbox?",
  component: FeatureDropdownInput,
};

export const lunchbox_desert_choice: Feature<string> = {
  name: 'Desert Choice',
  description: "What drink would you like inside your lunchbox?",
  component: FeatureDropdownInput,
};
