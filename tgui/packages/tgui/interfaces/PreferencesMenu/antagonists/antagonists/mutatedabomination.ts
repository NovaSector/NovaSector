import { type Antagonist, Category } from '../base';

const MutatedAbomination: Antagonist = {
  key: 'mutatedabomination',
  name: 'Mutated Abomination',
  description: [
    `
    A deadly pathogen has been released, turning crew members into mutated abominations.
    `,

    `
    You are a mutated abomination. You yearn for flesh. Your mind is torn apart, you do not remember who you are. \
    All you know is that you want to kill. \
    You retain some capability to reason. \
    Being friendly or helping crew will result in punishment. \
    Attacking your fellow zombies will result in punishment. \
    Hindering your fellow zombies will result in punishment.
    `,
  ],
  category: Category.Midround,
};

export default MutatedAbomination;
