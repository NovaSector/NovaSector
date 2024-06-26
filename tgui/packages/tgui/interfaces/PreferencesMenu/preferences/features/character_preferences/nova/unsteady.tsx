import { Feature, FeatureNumberInput } from '../../base';

export const unsteady_pushfactor: Feature<number> = {
  name: 'Chance on pushed',
  component: FeatureNumberInput,
};

export const unsteady_hurtfactor: Feature<number> = {
  name: 'Chance on hurt',
  component: FeatureNumberInput,
};

export const unsteady_stunlength: Feature<number> = {
  name: 'Length of stun',
  component: FeatureNumberInput,
};

export const unsteady_damagethreshold: Feature<number> = {
  name: 'Damage Threshold',
  component: FeatureNumberInput,

  description: 'Minimum damage required to knock you down.',
};
