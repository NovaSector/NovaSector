import { Feature, FeatureNumberInput } from '../../base';

export const bodytemp: Feature<number> = {
  name: 'Body Temperature Modifier',
  description: `
    Put some description here for the hover-over tooltip.
  `,
  component: FeatureNumberInput,
};
