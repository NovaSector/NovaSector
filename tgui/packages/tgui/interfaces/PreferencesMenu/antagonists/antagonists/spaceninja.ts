import { type Antagonist, Category } from '../base';

const SpaceNinja: Antagonist = {
  key: 'spaceninja',
  name: 'Space Ninja',
  /* NOVA EDIT ADDITION START */
  description: [
    `
      The Spider Clan are a small and mysterious faction, said to be neutrally aligned
      yet often carry out the most dangerous contracts available in the sector.
      Cybersun Industries persues Nanotrasen's technological advances closely, making
      a name for itself as their most feared competitor. The Spider Clan bushido are
      happy to oblige in driving that point home...
    `,
    `
      Become a conniving space ninja, equipped with a katana, gloves to hack
      into airlocks and APCs, a suit to make you go near-invisible,
      as well as a variety of abilities in your kit. Use everything available to
      complete your task of assassinating command members, and striking fear
      into the crew of Nanotrasen stations.
    `,
  ],
  /*description: [
    `
      The Spider Clan practice a sort of augmentation of human flesh in order to
      achieve a more perfect state of being and follow Postmodern Space Bushido.
    `,

    `
      Become a conniving space ninja, equipped with a katana, gloves to hack
      into airlocks and APCs, a suit to make you go near-invisible,
      as well as a variety of abilities in your kit. Hack into arrest consoles
      to mark everyone as arrest, and even hack into communication consoles to
      summon more threats to cause chaos on the station!
    `,
  ],*/
  /* NOVA EDIT ADDITION END */
  category: Category.Midround,
};

export default SpaceNinja;
