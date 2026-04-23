// THIS IS A NOVA SECTOR UI FILE
import type { ReactNode } from 'react';
import { Button, Dimmer, Section, Stack, Table } from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { useBackend } from '../backend';
import { Window } from '../layouts';

type CrewMember = { name: string; job: string };

type CryopodConsoleData = {
  frozen_crew: CrewMember[];
  item_ref_list: ItemRef[];
  item_ref_name: Record<string, string>;
  item_retrieval_allowed: BooleanLike;
};

export function CryopodConsole() {
  return (
    <Window title="Cryopod Console" width={420} height={480}>
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item grow>
            <CrewList />
          </Stack.Item>
          <Stack.Item grow>
            <ItemList />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
}

function CrewList() {
  const { data } = useBackend<CryopodConsoleData>();
  const { frozen_crew } = data;

  if (!frozen_crew?.length) {
    return <DimmedSection>There are no crew members stored.</DimmedSection>;
  }

  return (
    <Section fill scrollable>
      <Table>
        <Table.Row header>
          <Table.Cell>Name</Table.Cell>
          <Table.Cell align="right">Job</Table.Cell>
        </Table.Row>
        {frozen_crew.map((person) => (
          <Table.Row key={person.name} className="candystripe">
            <Table.Cell py="5px">{person.name}</Table.Cell>
            <Table.Cell py="5px" align="right">
              {person.job}
            </Table.Cell>
          </Table.Row>
        ))}
      </Table>
    </Section>
  );
}

function ItemList() {
  const { act, data } = useBackend<CryopodConsoleData>();
  const { item_ref_list, item_ref_name, item_retrieval_allowed } = data;

  if (!item_retrieval_allowed) {
    return (
      <DimmedSection>You are not authorized for item management.</DimmedSection>
    );
  }

  if (!item_ref_list?.length) {
    return <DimmedSection>There are no items stored.</DimmedSection>;
  }

  return (
    <Section fill scrollable>
      <Table>
        <Table.Row header>
          <Table.Cell>Item</Table.Cell>
          <Table.Cell align="right">Retrieve</Table.Cell>
        </Table.Row>
        {item_ref_list.map((item) => {
          return (
            <Table.Row key={item} className="candystripe">
              <Table.Cell py="2px">{item_ref_name[item]}</Table.Cell>
              <Table.Cell py="2px" align="right">
                <Button
                  icon="arrow-up"
                  onClick={() => act('item_get', { item_get: item })}
                />
              </Table.Cell>
            </Table.Row>
          );
        })}
      </Table>
    </Section>
  );
}

function DimmedSection(props: { children: ReactNode }) {
  const { children } = props;
  return (
    <Section fill>
      <Dimmer fontSize="150%" textAlign="center" bold>
        {children}
      </Dimmer>
    </Section>
  );
}
