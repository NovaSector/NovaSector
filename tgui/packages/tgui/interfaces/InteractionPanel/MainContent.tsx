// THIS IS A NOVA SECTOR UI FILE
import { useState } from 'react';
import {
  Button,
  Icon,
  Input,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { useBackend } from '../../backend';

enum InteractionTab {
  Interactions = 0,
  GenitalOptions = 1,
  LewdItems = 2,
}
type Interaction = {
  erp_interaction: BooleanLike;
  genital_config: { name: string; ref: string }[];
};

import { GenitalLayeringTab, InteractionsTab, LewdItemsTab } from './tabs';
export const MainContent = () => {
  const [searchText, setSearchText] = useState('');
  const [tabIndex, setTabIndex] = useState(InteractionTab.Interactions);
  const [showCategories, setShowCategories] = useState(true);
  const { data } = useBackend<Interaction>();
  const { erp_interaction, genital_config = [] } = data;
  const placeholder =
    tabIndex === InteractionTab.Interactions
      ? 'Search for an interaction'
      : tabIndex === InteractionTab.GenitalOptions
        ? 'Search for an item'
        : 'Searching is unavailable for this tab';
  return (
    <Section fill>
      <Stack vertical fill>
        <Stack.Item>
          <Tabs fluid textAlign="center">
            <Tabs.Tab
              selected={tabIndex === InteractionTab.Interactions}
              onClick={() => setTabIndex(InteractionTab.Interactions)}
            >
              Interactions
            </Tabs.Tab>
            {genital_config.length > 0 && (
              <Tabs.Tab
                selected={tabIndex === InteractionTab.LewdItems}
                onClick={() => setTabIndex(InteractionTab.LewdItems)}
              >
                Genital Options
              </Tabs.Tab>
            )}
            {erp_interaction && (
              <Tabs.Tab
                selected={tabIndex === InteractionTab.GenitalOptions}
                onClick={() => setTabIndex(InteractionTab.GenitalOptions)}
              >
                Lewd Items
              </Tabs.Tab>
            )}
          </Tabs>
        </Stack.Item>
        <Stack.Item>
          <Stack align="baseline" fill>
            <Stack.Item>
              <Icon name="search" />
            </Stack.Item>
            <Stack.Item grow>
              <Input
                fluid
                width="200px"
                value={searchText}
                placeholder={placeholder}
                onChange={(value) => setSearchText(value)}
              />
            </Stack.Item>
            {tabIndex === InteractionTab.Interactions && (
              <Stack.Item>
                <Button
                  icon={showCategories ? 'folder' : 'list'}
                  color="green"
                  tooltip={
                    showCategories ? 'Hide Categories' : 'Show Categories'
                  }
                  onClick={() => setShowCategories(!showCategories)}
                />
              </Stack.Item>
            )}
          </Stack>
        </Stack.Item>
        <Stack.Item grow mb={-1.6}>
          <Section fill>
            {tabIndex === InteractionTab.LewdItems ? (
              <GenitalLayeringTab />
            ) : tabIndex === InteractionTab.GenitalOptions ? (
              <LewdItemsTab searchText={searchText} />
            ) : (
              <InteractionsTab
                searchText={searchText}
                showCategories={showCategories}
              />
            )}
          </Section>
        </Stack.Item>
      </Stack>
    </Section>
  );
};
