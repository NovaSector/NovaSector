// THIS IS A NOVA SECTOR UI FILE
import { FeatureChoiced } from '../../base';
import { FeatureBloodTypeDropdownInput } from '../../dropdowns_nova';

export const unusual_biochemistry: FeatureChoiced<string> = {
  name: 'Blood Type',
  component: FeatureBloodTypeDropdownInput,
};
