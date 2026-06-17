import { CheckboxInput, type FeatureToggle } from '../../base';

export const birthday_opt_out: FeatureToggle = {
  name: 'Opt-Out Of Random Birthdays',
  description:
    'If selected, you will not be selected by the "Employee Birthday" station trait.',
  component: CheckboxInput,
};
