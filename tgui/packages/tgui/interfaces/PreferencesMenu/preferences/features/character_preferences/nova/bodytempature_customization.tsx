import { Feature, FeatureNumberInput } from '../../base';

export const bodytemp: Feature<number> = {
  name: 'Body Temperature Modifier',
  description: `
    Your body temperature can be set different from the standard,
    with the highest temp of 70 being equivalent to a skrell or as low as -20 with being equivalent to a plasmaman.
    Note that your safety is not guaranteed within the extremes, be mindful of your existence.
  `,
  component: FeatureNumberInput,
};
