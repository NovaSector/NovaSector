import { type Antagonist, Category } from '../base';

const BloodwashedMidround: Antagonist = {
  key: 'bloodwashedmidround',
  name: 'Bloodwashed',
  description: [
    `
      A lone occult antagonist whose mind cracks open partway through the
      shift under lingering blood cult influence.
    `,

    `
      You have scraps of cult rites, limited blood magic, and your own
      objectives. You cannot convert others or summon Nar'Sie.
    `,
  ],
  category: Category.Midround,
};

export default BloodwashedMidround;
