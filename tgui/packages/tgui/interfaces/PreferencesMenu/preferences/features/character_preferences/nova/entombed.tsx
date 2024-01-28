// THIS IS A NOVA SECTOR UI FILE
import {
  Feature,
  FeatureChoiced,
  FeatureDropdownInput,
  FeatureShortTextInput,
  FeatureTextInput,
} from '../../base';

export const entombed_skin: FeatureChoiced = {
  name: 'MODsuit Skin',
  component: FeatureDropdownInput,
};

export const entombed_mod_name: Feature<string> = {
  name: 'MODsuit Control Unit Name',
  component: FeatureShortTextInput,
};

export const entombed_mod_desc: Feature<string> = {
  name: 'MODsuit Control Unit Description',
  component: FeatureTextInput,
};

export const entombed_mod_prefix: Feature<string> = {
  name: 'MODsuit Deployed Prefix',
  description:
    "This is appended to any deployed pieces of MODsuit gear, like the chest, helmet, etc. The default is 'fused' - try to use an adjective, if you can.",
  component: FeatureShortTextInput,
};
