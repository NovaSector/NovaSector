// THIS IS A NOVA SECTOR UI FILE
import { type Feature, type FeatureChoiced, FeatureColorInput } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const psionic_rank: FeatureChoiced = {
  name: 'Psionic Rank',
  component: FeatureDropdownInput,
};

export const psionic_color: Feature<string> = {
  name: 'Psionic Color',
  component: FeatureColorInput,
};
