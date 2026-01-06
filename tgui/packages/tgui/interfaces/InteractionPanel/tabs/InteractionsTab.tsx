// THIS IS A NOVA SECTOR UI FILE
import { useMemo } from 'react';
import {
  Box,
  Button,
  Collapsible,
  NoticeBox,
  Section,
  Stack,
} from 'tgui-core/components';

import { useBackend } from '../../../backend';

type Interaction = {
  categories;
  interactions;
  descriptions;
  colors;
  self;
  ref_self;
  ref_user;
  block_interact;
  use_subtler;
}

interface InteractionsTabPropsData {
  searchText;
  showCategories;
};

export const InteractionsTab = ({searchText, showCategories}: InteractionsTabPropsData) => {
  const { act, data } = useBackend<Interaction>();
  const {
    categories = [],
    interactions = {},
    descriptions = {},
    colors = {},
    ref_self,
    ref_user,
    block_interact,
    use_subtler,
  } = data;

  const searchLower = searchText.toLowerCase();

  const renderInteractionButton = (interaction: string) => {
    return (
      <Button
        key={interaction}
        width="150px"
        lineHeight={1.75}
        disabled={block_interact}
        color={block_interact ? 'grey' : colors[interaction]}
        tooltip={block_interact
          ? 'You cannot interact right now'
          : descriptions[interaction]}
        icon="exclamation-circle"
        onClick={() =>
          act('interact', {
            interaction: interaction,
            selfref: ref_self,
            userref: ref_user,
            use_subtler,
          })
        }
      >
        {interaction}
      </Button>
    );
  };

  const filterInteractions = (category: string) => {
    let categoryInteractions = interactions[category] || [];
    if (searchText) {
      categoryInteractions = categoryInteractions.filter((interaction) =>
        interaction.toLowerCase().includes(searchLower),
      );
    }
    return categoryInteractions;
  };

  const getAllInteractions = () => {
    let allInteractions: Array<{
      name: string;
      category: string;
    }> = [];
    categories.forEach((category) => {
      const categoryInteractions = filterInteractions(category);
      allInteractions = allInteractions.concat(
        categoryInteractions.map((interaction) => ({
          name: interaction,
          category: category,
        })),
      );
    });
    return allInteractions;
  };

  return (
        <Stack fill vertical>
            {(block_interact && <NoticeBox>Unable to Interact</NoticeBox>) || (
                                <NoticeBox>Able to Interact</NoticeBox>
            )}
          <Stack.Item grow>
            {showCategories ? (
              categories.map((category) => {
                const filteredInteractions = filterInteractions(category);
                if (filteredInteractions.length === 0) return null;
                return (
                  <Collapsible
                    key={category}
                    title={category}
                    buttons={
                      <Box inline color="grey" fontSize={0.9}>
                        {filteredInteractions.length}
                        {' interactions'}
                      </Box>
                    }
                  >
                    <Section fill>
                      <Box mt={0.2}>
                        {filteredInteractions.map((interaction) => (
                          renderInteractionButton(interaction)
                        ))}
                      </Box>
                    </Section>
                  </Collapsible>
                );
              })
            ) : (
              <Section fill>
                <Box mt={0.2}>
                  {getAllInteractions().map(({ name, category }) => (
                    renderInteractionButton(name)
                  ))}
                </Box>
              </Section>
            )}
          </Stack.Item>
        </Stack>
  );
};
