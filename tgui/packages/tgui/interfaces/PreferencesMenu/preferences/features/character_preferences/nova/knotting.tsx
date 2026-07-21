// THIS IS A NOVA SECTOR UI FILE
import { CheckboxInput, type FeatureToggle } from '../../base';

export const has_knot: FeatureToggle = {
  name: 'Knotting - Has Knot',
  description:
    'Your character has a knot. Climaxing inside an opted-in partner starts a temporary tie and lets you pull them with you. Requires an exposed penis.',
  component: CheckboxInput,
};

export const knotting_receive: FeatureToggle = {
  name: 'Knotting - Allow receiving',
  description:
    'Partners with the knotting trait can knot you when they climax inside. Without this, their knot slips free.',
  component: CheckboxInput,
};
