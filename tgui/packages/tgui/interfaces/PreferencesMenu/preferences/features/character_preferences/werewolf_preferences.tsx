import {
  type Feature,
  FeatureColorInput,
  FeatureNumberInput,
} from '../base';

export const werewolf_fur_color: Feature<string> = {
  name: 'Werewolf fur color',
  component: FeatureColorInput,
};

export const werewolf_size_delta: Feature<number> = {
  name: 'Werewolf size bump',
  component: FeatureNumberInput,
};
