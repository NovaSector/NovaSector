// THIS IS A NOVA SECTOR UI FILE
import {
  Feature,
  FeatureChoiced,
  FeatureDropdownInput,
  FeatureShortTextInput,
  FeatureTextInput,
} from '../../base';

export const uplink_skin: FeatureChoiced = {
  name: 'Uplink Skin',
  component: FeatureDropdownInput,
};

export const uplink_name: Feature<string> = {
  name: 'Uplink Name',
  component: FeatureShortTextInput,
};

export const uplink_desc: Feature<string> = {
  name: 'Uplink Description',
  component: FeatureTextInput,
};
