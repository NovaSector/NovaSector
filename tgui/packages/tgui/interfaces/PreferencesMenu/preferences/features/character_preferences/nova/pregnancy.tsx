// THIS IS A NOVA SECTOR UI FILE
import {
  CheckboxInput,
  type Feature,
  type FeatureChoiced,
  type FeatureChoicedServerData,
  FeatureNumberInput,
  type FeatureValueProps,
} from '../../base';
import { FeatureDropdownInput } from '../../dropdowns';

export const pregnancy_chance: Feature<number> = {
  name: 'Pregnancy - Chance %',
  description:
    'Percent chance to become pregnant when someone climaxes inside you.',
  component: FeatureNumberInput,
};

export const pregnancy_duration: Feature<number> = {
  name: 'Pregnancy - Duration (minutes)',
  description: 'Time, in minutes, from conception to giving birth.',
  component: FeatureNumberInput,
};

export const pregnancy_cryptic: Feature<boolean> = {
  name: 'Pregnancy - Cryptic',
  description: 'If enabled, health analyzers will not reveal the pregnancy.',
  component: CheckboxInput,
};

export const pregnancy_belly_inflation: Feature<boolean> = {
  name: 'Pregnancy - Belly inflation',
  description:
    'If enabled, pregnancy produces flavor messages about your belly swelling during gestation.',
  component: CheckboxInput,
};

export const pregnancy_nausea: Feature<boolean> = {
  name: 'Pregnancy - Nausea',
  description: 'If enabled, pregnancy periodically causes disgust buildup.',
  component: CheckboxInput,
};

export const pregnancy_egg_skin: FeatureChoiced = {
  name: 'Pregnancy - Egg appearance',
  description: 'Which egg sprite is used when you lay your egg.',
  component: (
    props: FeatureValueProps<string, string, FeatureChoicedServerData>,
  ) => {
    return <FeatureDropdownInput buttons {...props} />;
  },
};
