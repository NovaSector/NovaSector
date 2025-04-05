// THIS IS A NOVA SECTOR UI FILE
import { FeatureBloodTypeDropdownInput } from '../../dropdowns_nova';
import { FeatureChoiced } from '../base';

export const unusual_biochemistry: FeatureChoiced<string> = {
  name: 'Blood Type',
  component: FeatureBloodTypeDropdownInput,
};
