// THIS IS A NOVA SECTOR UI FILE
import {
  CheckboxInput,
  type Feature,
  FeatureNumberInput,
} from '../../base';

export const pregnancy_chance: Feature<number> = {
  name: 'Pregnancy - Chance %',
  description:
    'Percent chance to become pregnant when someone climaxes inside you.',
  component: FeatureNumberInput,
};

export const pregnancy_start_pregnant: Feature<boolean> = {
  name: 'Pregnancy - Start pregnant',
  description: 'If enabled, you will start the round already pregnant.',
  component: CheckboxInput,
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
