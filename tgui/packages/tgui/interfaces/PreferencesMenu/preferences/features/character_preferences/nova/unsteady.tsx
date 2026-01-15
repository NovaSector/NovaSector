// THIS IS A NOVA SECTOR UI FILE
import { type Feature, FeatureNumberInput } from '../../base';

export const unsteady_hurtfactor: Feature<number> = {
  name: 'Chance on hurt',
  component: FeatureNumberInput,
};

export const unsteady_stunlength: Feature<number> = {
  name: 'Length of falldown',
  component: FeatureNumberInput,
};

export const unsteady_damagethreshold: Feature<number> = {
  name: 'Damage threshold',
  component: FeatureNumberInput,
  description: 'Minimum damage required to knock you down.',
};
