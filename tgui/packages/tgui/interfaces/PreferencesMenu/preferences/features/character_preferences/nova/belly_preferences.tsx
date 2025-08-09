// THIS IS A NOVA SECTOR UI FILE
import {
  CheckboxInput,
  Feature,
  FeatureChoiced,
  FeatureColorInput,
  FeatureNumberInput,
  FeatureSliderInput,
  FeatureToggle,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const erp_belly_vore_prey: FeatureChoiced = {
  name: 'Vore Prey Preference',
  category: 'BELLY',
  description:
    'Determines whether or not you partake in the belly system to engage in vore as a prey.  Never means you can never be a prey, query means you always get queried before someome tries to take you, always means you always consent.',
  component: FeatureDropdownInput,
};

// QUIRK CONTENT BREAKER
export const erp_bellyquirk_color: Feature<string> = {
  name: 'Belly Color',
  description:
    'Belly coloration. Match this to your skin, Augments+ or Mutant Colors to make it look smooth, and toggle Use Skintone if your torso uses a skintone spritesheet.',
  component: FeatureColorInput,
};

export const erp_bellyquirk_skintone: FeatureToggle = {
  name: 'Belly Uses Skintone',
  category: 'BELLY',
  description:
    'Use skintone spritesheets for better matching coloration on human-esque characters.',
  component: CheckboxInput,
};

export const erp_bellyquirk_sizemod: Feature<number> = {
  name: 'Belly Sizemod',
  component: FeatureSliderInput,
  description:
    'Size multiplier - all belly size sources are multiplied by this for determining overall impact.',
};

export const erp_bellyquirk_sizemod_autostuffed: Feature<number> = {
  name: 'Belly Sizemod - Nutrition',
  component: FeatureSliderInput,
  description:
    'Size multiplier - applies to the contribution of your nutrition & stomach reagents to autocalculated stuffed size.',
};

export const erp_bellyquirk_sizemod_audio: Feature<number> = {
  name: 'Belly Sizemod - Audio',
  component: FeatureSliderInput,
  description:
    'Size multiplier for audio - all belly size sources are multiplied by this for determining audio intensity.',
};

export const erp_bellyquirk_size_base: Feature<number> = {
  name: 'Base Size - Cosmetic',
  component: FeatureNumberInput,
  description: 'Provides a baseline cosmetic belly size with no noises.',
};

export const erp_bellyquirk_size_full: Feature<number> = {
  name: 'Base Size - Fullness',
  component: FeatureNumberInput,
  description:
    'Provides a baseline cosmetic belly size with gentle fullness creaks & groans.',
};

export const erp_bellyquirk_size_stuffed: Feature<number> = {
  name: 'Base Size - Stuffed',
  component: FeatureNumberInput,
  description:
    'Provides a baseline cosmetic belly size with gurgles, churns & sloshes from stuffed fullness.',
};

export const erp_bellyquirk_sound_groans: FeatureToggle = {
  name: 'Allow Sound: Full Groans',
  category: 'BELLY',
  description: 'When enabled, allows your belly to emit creaks while full.',
  component: CheckboxInput,
};

export const erp_bellyquirk_sound_gurgles: FeatureToggle = {
  name: 'Allow Sound: Stuffed Gurgles',
  category: 'BELLY',
  description: 'When enabled, allows your belly to emit gurgles while stuffed.',
  component: CheckboxInput,
};

export const erp_bellyquirk_sound_move_creaks: FeatureToggle = {
  name: 'Allow Sound: Full Movement Creaks',
  category: 'BELLY',
  description:
    'When enabled, allows your belly to emit creaks from being jostled by movement while full.',
  component: CheckboxInput,
};

export const erp_bellyquirk_sound_move_sloshes: FeatureToggle = {
  name: 'Allow Sound: Stuffed Movement Sloshes',
  category: 'BELLY',
  description:
    'When enabled, allows your belly to emit sloshes from being jostled by movement while stuffed.',
  component: CheckboxInput,
};

export const erp_bellyquirk_pred: FeatureChoiced = {
  name: 'Pred Preference',
  category: 'BELLY',
  description:
    'Determines whether or not you can vore people as a pred with the belly.  Never means you can never be a pred, query means you always get queried before trying, always means you always try.',
  component: FeatureDropdownInput,
};

export const erp_bellyquirk_maxsize: Feature<number> = {
  name: 'Maximum Belly Size',
  category: 'BELLY',
  component: FeatureSliderInput,
  description:
    'Sets the maximum size of belly sprite your belly will ever reach. Size 4 and beyond are large, size 8 and beyond are hyper, size 11 and beyond are very hyper.',
};
