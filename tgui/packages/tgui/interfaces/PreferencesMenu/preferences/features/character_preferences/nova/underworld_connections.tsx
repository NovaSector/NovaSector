// THIS IS A NOVA SECTOR UI FILE
import {
  Feature,
  FeatureChoiced,
  FeatureShortTextInput,
  FeatureTextInput,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const underworld_uplink_skin: FeatureChoiced = {
  name: 'Uplink Skin',
  component: FeatureDropdownInput,
};

export const underworld_uplink_name: Feature<string> = {
  name: 'Uplink Name',
  component: FeatureShortTextInput,
};

export const underworld_uplink_desc: Feature<string> = {
  name: 'Uplink Description',
  component: FeatureTextInput,
};
