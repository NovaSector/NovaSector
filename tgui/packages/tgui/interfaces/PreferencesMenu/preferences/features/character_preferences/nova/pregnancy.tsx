// THIS IS A NOVA SECTOR UI FILE
import {
  CheckboxInput,
  type Feature,
  type FeatureChoiced,
  type FeatureChoicedServerData,
  FeatureNumberInput,
  FeatureShortTextInput,
  type FeatureValueProps,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const custom_taste: Feature<string> = {
  name: 'Taste',
  description:
    'Short text describing how your character tastes. Shown when someone licks you (IC verb) and in some vore interactions.',
  component: FeatureShortTextInput,
};

export const custom_smell: Feature<string> = {
  name: 'Smell',
  description:
    'Short text describing how your character smells. Shown when someone uses the Smell IC verb on you.',
  component: FeatureShortTextInput,
};

export const low_arousal_text: Feature<string> = {
  name: 'Low arousal flavor',
  description:
    'Short text shown on examine when your character is slightly aroused. ERP pref must be on for both you and the examiner.',
  component: FeatureShortTextInput,
};

export const medium_arousal_text: Feature<string> = {
  name: 'Medium arousal flavor',
  description:
    'Short text shown on examine when your character is moderately aroused. ERP pref must be on for both you and the examiner.',
  component: FeatureShortTextInput,
};

export const high_arousal_text: Feature<string> = {
  name: 'High arousal flavor',
  description:
    'Short text shown on examine when your character is highly aroused. ERP pref must be on for both you and the examiner.',
  component: FeatureShortTextInput,
};

export const pregnancy_chance: Feature<number> = {
  name: 'Pregnancy chance',
  description:
    'Percent chance to become pregnant when someone climaxes inside you through an enabled insemination route.',
  component: FeatureNumberInput,
};

export const pregnancy_duration: Feature<number> = {
  name: 'Pregnancy duration (minutes)',
  description:
    'Time, in minutes, from conception to giving birth.',
  component: FeatureNumberInput,
};

export const pregnancy_cryptic: Feature<boolean> = {
  name: 'Cryptic pregnancy',
  description:
    'If enabled, health analyzers will not reveal the pregnancy.',
  component: CheckboxInput,
};

export const pregnancy_inert: Feature<boolean> = {
  name: 'Inert egg',
  description:
    'If enabled, the egg laid will not contain a live offspring — only the egg is produced.',
  component: CheckboxInput,
};

export const pregnancy_belly_inflation: Feature<boolean> = {
  name: 'Belly inflation',
  description:
    'If enabled, pregnancy produces flavor messages about your belly swelling during gestation.',
  component: CheckboxInput,
};

export const pregnancy_nausea: Feature<boolean> = {
  name: 'Pregnancy nausea',
  description:
    'If enabled, pregnancy periodically causes disgust buildup.',
  component: CheckboxInput,
};

export const pregnancy_insemination_vagina: Feature<boolean> = {
  name: 'Vaginal insemination',
  description:
    'If enabled, cum deposited in your vagina can trigger pregnancy.',
  component: CheckboxInput,
};

export const pregnancy_insemination_anus: Feature<boolean> = {
  name: 'Anal insemination',
  description:
    'If enabled, cum deposited in your anus can trigger pregnancy.',
  component: CheckboxInput,
};

export const pregnancy_insemination_mouth: Feature<boolean> = {
  name: 'Oral insemination',
  description:
    'If enabled, cum deposited in your mouth can trigger pregnancy.',
  component: CheckboxInput,
};

export const pregnancy_egg_skin: FeatureChoiced = {
  name: 'Egg appearance',
  description:
    'Which egg sprite is used when you lay your egg.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};
