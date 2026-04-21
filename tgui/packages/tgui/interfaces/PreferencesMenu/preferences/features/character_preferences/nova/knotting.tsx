// THIS IS A NOVA SECTOR UI FILE
import { CheckboxInput, type Feature } from '../../base';

export const knotting_enable: Feature<boolean> = {
  name: 'Knotting - Enable',
  description:
    "Your character has a knot. Climaxing inside a consenting partner triggers a temporary tie via aggressive grab. Requires a penis.",
  component: CheckboxInput,
};

export const knotting_receive: Feature<boolean> = {
  name: 'Knotting - Allow receiving',
  description:
    'Partners with the knotting trait can knot you when they climax inside. Without this, their knot just slips free.',
  component: CheckboxInput,
};
