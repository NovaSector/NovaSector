// THIS IS A NOVA SECTOR UI FILE
import type { FeatureChoiced } from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const blood_type: FeatureChoiced = {
  name: 'Blood Type',
  description: "Dictates character's blood type.",
  component: FeatureDropdownInput,
};
