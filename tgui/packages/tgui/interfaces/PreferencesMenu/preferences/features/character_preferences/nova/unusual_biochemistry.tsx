// THIS IS A NOVA SECTOR UI FILE
import {
  FeatureBloodTypeDropdownInput,
  type FeatureWithExtraQuirkData,
} from '../../dropdowns_nova';

export const unusual_biochemistry: FeatureWithExtraQuirkData<string> = {
  name: 'Blood Type',
  component: FeatureBloodTypeDropdownInput,
};
