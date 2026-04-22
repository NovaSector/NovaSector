// THIS IS A NOVA SECTOR UI FILE
import { useBackend } from 'tgui/backend';
import { Box, Section, Stack } from 'tgui-core/components';
import type { NifPanelData } from './data';
import { NifProgram } from './NifProgram';

export function NifProgramList() {
  const { data } = useBackend<NifPanelData>();
  const { loaded_nifsofts, max_nifsofts } = data;

  return (
    <Section
      title={`NIFSoft Programs (${max_nifsofts - loaded_nifsofts.length} slots available)`}
    >
      {loaded_nifsofts.length ? (
        <Stack direction="column">
          {loaded_nifsofts.map((nifsoft) => (
            <Stack.Item key={nifsoft.name}>
              <NifProgram src={nifsoft} />
            </Stack.Item>
          ))}
        </Stack>
      ) : (
        <Box p="5px">
          <Box color="grey">There are no NIFSofts currently installed.</Box>
        </Box>
      )}
    </Section>
  );
}
