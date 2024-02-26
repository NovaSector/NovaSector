// THIS IS A NOVA SECTOR UI FILE
import { useState } from 'react';

import { useBackend } from '../backend';
import {
  Box,
  Button,
  Icon,
  LabeledList,
  Section,
  Stack,
  Table,
} from '../components';
import { Window } from '../layouts';
import { CharacterPreview } from './common/CharacterPreview';

const erpTagColor = {
  Unset: 'label',
  'Yes - Dom': '#570000',
  'Yes - Sub': '#002B57',
  'Yes - Switch': '#572b57',
  Yes: '#022E00',
  'Check OOC': '#333333',
  Ask: '#333333',
  No: '#000000',
};

export const NovaCharacterDirectory = (props) => {
  const { data } = useBackend();

  const {
    personalVisibility,
    personalAttraction,
    personalGender,
    personalErpTag,
    personalVoreTag,
    personalNonconTag,
  } = data;

  const [overlay, setOverlay] = useState(null);
  const updateOverlay = (character) => {
    setOverlay(character);
  };

  return (
    <Window width={900} height={640} resizeable>
      <Window.Content scrollable>
        {(overlay && (
          <ViewCharacter overlay={overlay} updateOverlay={updateOverlay} />
        )) || (
          <>
            <Section title="Controls">
              <LabeledList>
                <LabeledList.Item label="Visibility">
                  <Button fluid>
                    {personalVisibility ? 'Shown' : 'Not Shown'}
                  </Button>
                </LabeledList.Item>
                <LabeledList.Item label="Attraction">
                  <Button fluid>{personalAttraction}</Button>
                </LabeledList.Item>
                <LabeledList.Item label="Gender">
                  <Button fluid>{personalGender}</Button>
                </LabeledList.Item>
                <LabeledList.Item label="ERP">
                  <Button fluid>{personalErpTag}</Button>
                </LabeledList.Item>
                <LabeledList.Item label="Vore">
                  <Button fluid>{personalVoreTag}</Button>
                </LabeledList.Item>
                <LabeledList.Item label="Noncon">
                  <Button fluid>{personalNonconTag}</Button>
                </LabeledList.Item>
              </LabeledList>
            </Section>
            <CharacterDirectoryList
              overlay={overlay}
              updateOverlay={updateOverlay}
            />
          </>
        )}
      </Window.Content>
    </Window>
  );
};

const ViewCharacter = (props) => {
  const { overlay, updateOverlay } = props;

  return (
    <Section
      title={overlay.name}
      buttons={
        <Button icon="arrow-left" onClick={() => updateOverlay(null)}>
          Back
        </Button>
      }
    >
      <Stack fill>
        <Stack.Item>
          <CharacterPreview height="100%" id={overlay.assigned_view} />
        </Stack.Item>
      </Stack>
      <Section level={2} title="Species">
        <Box>{overlay.species}</Box>
      </Section>
      <Section level={2} title="Character Ad">
        <Box style={{ 'word-break': 'break-all' }} preserveWhitespace>
          {overlay.character_ad || 'Unset.'}
        </Box>
      </Section>
      <Section level={2} title="Flavor Text">
        <Box style={{ 'word-break': 'break-all' }} preserveWhitespace>
          {overlay.flavor_text || 'Unset.'}
        </Box>
      </Section>
      <Section level={2} title="Gender">
        <Box>{overlay.gender}</Box>
      </Section>
      <Section level={2} title="Attraction">
        <Box>{overlay.attraction}</Box>
      </Section>
      <Section level={2} title="ERP">
        <Box p={1} backgroundColor={erpTagColor[overlay.erp]}>
          {overlay.erp}
        </Box>
        <Section level={2} title="Vore">
          <Box>{overlay.vore}</Box>
        </Section>
      </Section>
      <Section level={2} title="Noncon">
        <Box>{overlay.noncon}</Box>
      </Section>
      <Section level={2} title="Exploitable">
        <Box style={{ 'word-break': 'break-all' }} preserveWhitespace>
          {overlay.exploitable || 'Unset.'}
        </Box>
      </Section>
      <Section level={2} title="OOC Notes">
        <Box style={{ 'word-break': 'break-all' }} preserveWhitespace>
          {overlay.ooc_notes || 'Unset.'}
        </Box>
      </Section>
    </Section>
  );
};

const CharacterDirectoryList = (props) => {
  const { act, data } = useBackend();
  const { overlay, updateOverlay } = props;

  const { directory, canOrbit, assigned_view } = data;

  const [sortId, _setSortId] = useState('name');
  const [sortOrder, _setSortOrder] = useState('name');

  return (
    <Section
      title="Directory"
      buttons={
        <Button icon="sync" onClick={() => act('refresh')}>
          Refresh
        </Button>
      }
    >
      <Table>
        <Table.Row bold>
          <SortButton id="name">Name</SortButton>
          <SortButton id="species">Species</SortButton>
          <SortButton id="attraction">Attraction</SortButton>
          <SortButton id="gender">Gender</SortButton>
          <SortButton id="erp">ERP</SortButton>
          <SortButton id="vore">Vore</SortButton>
          <SortButton id="noncon">Noncon</SortButton>
          <Table.Cell collapsing textAlign="right">
            Advert
          </Table.Cell>
        </Table.Row>
        {directory
          .sort((a, b) => {
            const i = sortOrder ? 1 : -1;
            return a[sortId].localeCompare(b[sortId]) * i;
          })
          .map((character, i) => (
            <Table.Row key={i} backgroundColor={erpTagColor[character.erp]}>
              <Table.Cell p={1}>
                {canOrbit ? (
                  <Button
                    color={erpTagColor[character.erp]}
                    icon="ghost"
                    tooltip="Orbit"
                    onClick={() => act('orbit', { ref: character.ref })}
                  >
                    {character.name}
                  </Button>
                ) : (
                  character.name
                )}
              </Table.Cell>
              <Table.Cell>{character.species}</Table.Cell>
              <Table.Cell>{character.attraction}</Table.Cell>
              <Table.Cell>{character.gender}</Table.Cell>
              <Table.Cell>{character.erp}</Table.Cell>
              <Table.Cell>{character.vore}</Table.Cell>
              <Table.Cell>{character.noncon}</Table.Cell>
              <Table.Cell collapsing textAlign="right">
                <Button
                  onClick={
                    (() =>
                      act('view_character', {
                        assigned_view: assigned_view,
                        appearance: character.appearance,
                      }),
                    () => updateOverlay(character))
                  }
                  color="transparent"
                  icon="sticky-note"
                  mr={1}
                >
                  View
                </Button>
              </Table.Cell>
            </Table.Row>
          ))}
      </Table>
    </Section>
  );
};

const SortButton = (props) => {
  const { act, data } = useBackend();

  const { id, children } = props;

  // Hey, same keys mean same data~
  const [sortId, setSortId] = useState('name');
  const [sortOrder, setSortOrder] = useState('name');

  return (
    <Table.Cell collapsing>
      <Button
        width="100%"
        color={sortId !== id && 'transparent'}
        onClick={() => {
          if (sortId === id) {
            setSortOrder(!sortOrder);
          } else {
            setSortId(id);
            setSortOrder(true);
          }
        }}
      >
        {children}
        {sortId === id && (
          <Icon name={sortOrder ? 'sort-up' : 'sort-down'} ml={0.25} />
        )}
      </Button>
    </Table.Cell>
  );
};
