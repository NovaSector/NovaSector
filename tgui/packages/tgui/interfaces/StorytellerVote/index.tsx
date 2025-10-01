import { Box, Button, Divider, LabeledList, NoticeBox, Section, Stack } from 'tgui-core/components';
import { useBackend, useLocalState } from '../../backend';
import { Window } from '../../layouts';

// Backend contract
// static: storytellers: [{ id, name, desc, portrait }], min_difficulty, max_difficulty
// data: selection, difficulty

type Candidate = {
  id: string;
  name: string;
  desc?: string;
  portrait?: string | null;
};

export const StorytellerVote = (props) => {
  const { data, act, config } = useBackend();
  const storytellers: Candidate[] = (config && (config as any).storytellers) || [];
  const min_difficulty: number = (config && (config as any).min_difficulty) || 0.3;
  const max_difficulty: number = (config && (config as any).max_difficulty) || 5.0;

  const selection: string | undefined = data && (data as any).selection;
  const difficulty: number = (data && (data as any).difficulty) || 1.0;

  const [selected, setSelected] = useLocalState('selected', selection || '');
  const [diff, setDiff] = useLocalState('diff', String(difficulty));

  const select = (id: string) => {
    setSelected(id);
    act('vote_select', { id });
  };

  const applyDifficulty = (value: string) => {
    setDiff(value);
    const v = Math.max(min_difficulty, Math.min(max_difficulty, Number(value) || 1));
    act('vote_difficulty', { value: v });
  };

  const current = storytellers.find((c) => c.id === selected) || storytellers[0];

  return (
    <Window title="Vote for Storyteller" width={760} height={560}>
      <Window.Content scrollable>
        <Stack>
          <Stack.Item minWidth={260} grow={0} basis={260}>
            <Section title="Candidates">
              {storytellers.length ? (
                storytellers.map((c) => (
                  <Box
                    key={c.id}
                    p={1}
                    mb={1}
                    backgroundColor={c.id === selected ? 'rgba(255,255,255,0.08)' : undefined}
                    onClick={() => select(c.id)}
                    style={{ cursor: 'pointer', borderRadius: 4 }}
                  >
                    <Stack align="center">
                      <Stack.Item>
                        {/* Portrait placeholder; hook into asset path if available */}
                        <Box width={48} height={48} backgroundColor="#222" mr={1} />
                      </Stack.Item>
                      <Stack.Item grow>
                        <b>{c.name}</b>
                        {c.desc ? (
                          <Box opacity={0.6} mt={0.5} maxWidth={180} style={{ overflow: 'hidden', textOverflow: 'ellipsis', whiteSpace: 'nowrap' }}>
                            {c.desc}
                          </Box>
                        ) : null}
                      </Stack.Item>
                    </Stack>
                  </Box>
                ))
              ) : (
                <NoticeBox>No storytellers available.</NoticeBox>
              )}
            </Section>
          </Stack.Item>

          <Stack.Item grow>
            <Section title="Details">
              {current ? (
                <>
                  <LabeledList>
                    <LabeledList.Item label="Name">{current.name}</LabeledList.Item>
                    <LabeledList.Item label="Description">
                      {current.desc || '—'}
                    </LabeledList.Item>
                  </LabeledList>

                  <Divider />

                  <LabeledList>
                    <LabeledList.Item label="Difficulty">
                      <Stack align="center">
                        <Stack.Item grow>
                          <input
                            type="range"
                            min={min_difficulty}
                            max={max_difficulty}
                            step={0.05}
                            value={diff}
                            onChange={(e) => applyDifficulty(e.currentTarget.value)}
                            style={{ width: '100%' }}
                          />
                        </Stack.Item>
                        <Stack.Item>
                          <Box ml={1}>{Math.round((Number(diff) || 1) * 100)}%</Box>
                        </Stack.Item>
                      </Stack>
                    </LabeledList.Item>
                  </LabeledList>

                  <Stack mt={2}>
                    <Stack.Item>
                      <Button
                        icon="check"
                        disabled={!selected}
                        onClick={() => act('vote_submit')}
                      >
                        Submit Vote
                      </Button>
                    </Stack.Item>
                  </Stack>
                </>
              ) : (
                <NoticeBox>Select a storyteller on the left.</NoticeBox>
              )}
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
