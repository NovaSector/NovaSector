// THIS IS A NOVA SECTOR UI FILE
import { useState } from 'react';

import { useBackend } from '../backend';
import {
  Button,
  Icon,
  LabeledList,
  NoticeBox,
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
    assigned_view,
  } = data;

  const [overlay, setOverlay] = useState(null);
  const updateOverlay = (character) => {
    setOverlay(character);
  };

  return (
    <Window width={900} height={640} resizeable>
      <Window.Content scrollable>
        {(overlay && (
          <ViewCharacter
            overlay={overlay}
            updateOverlay={updateOverlay}
            assigned_view={assigned_view}
          />
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
  const { overlay, updateOverlay, assigned_view } = props;

  return (
    <Stack fill vertical>
      <Stack.Item grow={2}>
        <Stack>
          <Stack.Item grow>
            <Stack fill>
              <Stack.Item>
                <CharacterPreview height="100%" id={assigned_view} />
              </Stack.Item>
            </Stack>
          </Stack.Item>

          <Stack.Item grow>
            <Section>
              <LabeledList>
                <LabeledList.Item label="Gender">
                  {overlay.gender}
                </LabeledList.Item>
                <LabeledList.Item label="Species">
                  {overlay.species}
                </LabeledList.Item>
                <LabeledList.Item label="Character Ad">
                  {overlay.character_ad || 'Unset.'}
                </LabeledList.Item>
                <LabeledList.Item label="Flavor Text">
                  {overlay.flavor_text || 'Unset.'}
                </LabeledList.Item>
                <LabeledList.Item label="ERP">{overlay.erp}</LabeledList.Item>
                <LabeledList.Item label="Vore">{overlay.vore}</LabeledList.Item>
                <LabeledList.Item label="Noncon">
                  {overlay.noncon}
                </LabeledList.Item>
                <LabeledList.Item label="Exploitables">
                  {overlay.exploitable || 'Unset.'}
                </LabeledList.Item>
                <LabeledList.Item label="OOC Notes">
                  {overlay.ooc_notes || 'Unset.'}
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Stack.Item>

          <Stack.Item grow={2}>
            <Section fill scrollable>
              <LabeledList>
                <LabeledList.Item label="Exploitables">
                  {overlay.exploitable || 'Unset.'}
                </LabeledList.Item>
                <LabeledList.Item label="OOC Notes">
                  {overlay.ooc_notes || 'Unset.'}
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Stack.Item>
        </Stack>
      </Stack.Item>

      <Stack.Item>
        <NoticeBox color="pink" align="right">
          <Button icon="arrow-left" onClick={() => updateOverlay(null)}>
            Back
          </Button>
        </NoticeBox>
      </Stack.Item>
    </Stack>
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
                  onClick={() => {
                    updateOverlay(character);
                    act('view_character', {
                      assigned_view: assigned_view,
                      name: character.appearance_name,
                    });
                  }}
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
