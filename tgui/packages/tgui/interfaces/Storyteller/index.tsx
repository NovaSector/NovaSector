import {
  Box,
  Button,
  Divider,
  Dropdown,
  LabeledList,
  NoticeBox,
  ProgressBar,
  Section,
  Stack,
  Tabs,
} from 'tgui-core/components';
import type { BooleanLike } from 'tgui-core/react';
import { useBackend, useLocalState } from '../../backend';
import { Window } from '../../layouts';

// Data contract expected from backend
// Adjust on the BYOND side to match these names or adapt here accordingly

type StorytellerGoal = {
  id: string;
  name?: string;
  weight?: number;
  progress?: number; // 0..1
};

type StorytellerMood = {
  id: string;
  name: string;
  pace: number; // multiplier (e.g. 0.5 fast, 2.0 slow)
  threat?: number; // optional UI hint
};

type StorytellerEventLog = {
  time: number; // world.time
  desc: string;
};

type StorytellerData = {
  name: string;
  desc?: string;
  mood?: StorytellerMood;
  current_global_goal?: StorytellerGoal | null;
  current_subgoal?: StorytellerGoal | null;
  global_goal_progress?: number; // 0..1
  global_goal_weight?: number;
  next_think_time?: number;
  base_think_delay?: number;
  min_event_interval?: number;
  max_event_interval?: number;
  recent_events?: StorytellerEventLog[];
  player_count?: number;
  antag_count?: number;
  player_antag_balance?: number; // 0..100
  event_difficulty_modifier?: number;
  available_moods?: StorytellerMood[];
  available_goals?: StorytellerGoal[];
  can_force_event?: BooleanLike;
};

const formatTime = (ticks?: number) => {
  if (!ticks && ticks !== 0) return '—';
  // world.tick_lag is commonly 0.5, but we can't rely on it at UI level
  // Display raw ticks and seconds (assuming 10 ticks per second)
  const seconds = Math.floor((ticks as number) / 10);
  return `${ticks}t (${seconds}s)`;
};

const ProgressRow = ({ label, value }: { label: string; value?: number }) => {
  const pct = Math.max(0, Math.min(1, value ?? 0));
  return (
    <LabeledList.Item label={label}>
      <ProgressBar value={pct}>{Math.round(pct * 100)}%</ProgressBar>
    </LabeledList.Item>
  );
};

export const Storyteller = (props) => {
  const { data, act } = useBackend<StorytellerData>();
  const {
    name,
    desc,
    mood,
    current_global_goal,
    current_subgoal,
    global_goal_progress,
    global_goal_weight,
    next_think_time,
    base_think_delay,
    min_event_interval,
    max_event_interval,
    recent_events = [],
    player_count,
    antag_count,
    player_antag_balance,
    event_difficulty_modifier,
    available_moods = [],
    available_goals = [],
    can_force_event,
  } = data;

  const [tab, setTab] = useLocalState<'overview' | 'goals' | 'settings'>(
    'tab',
    'overview',
  );
  const [selectedMood, setSelectedMood] = useLocalState(
    'selectedMood',
    mood?.id || '',
  );
  const [pace, setPace] = useLocalState('pace', String(mood?.pace ?? 1.0));
  const [selectedGoal, setSelectedGoal] = useLocalState('selectedGoal', '');

  return (
    <Window
      title={`Storyteller — ${name || 'Unknown'}`}
      width={720}
      height={640}
    >
      <Window.Content scrollable>
        <Tabs>
          <Tabs.Tab
            selected={tab === 'overview'}
            icon="info"
            onClick={() => setTab('overview')}
          >
            Overview
          </Tabs.Tab>
          <Tabs.Tab
            selected={tab === 'goals'}
            icon="flag-checkered"
            onClick={() => setTab('goals')}
          >
            Goals
          </Tabs.Tab>
          <Tabs.Tab
            selected={tab === 'settings'}
            icon="cog"
            onClick={() => setTab('settings')}
          >
            Settings
          </Tabs.Tab>
        </Tabs>

        <Divider />

        {tab === 'overview' && (
          <>
            {desc ? <NoticeBox>{desc}</NoticeBox> : null}

            <Section title="Status">
              <LabeledList>
                <LabeledList.Item label="Mood">
                  {mood ? `${mood.name} (pace ×${mood.pace})` : '—'}
                </LabeledList.Item>
                <LabeledList.Item label="Players / Antags">
                  {player_count ?? '—'} / {antag_count ?? '—'}
                </LabeledList.Item>
                <LabeledList.Item label="Balance">
                  {player_antag_balance ?? '—'}
                </LabeledList.Item>
                <LabeledList.Item label="Event Difficulty">
                  ×{event_difficulty_modifier ?? 1}
                </LabeledList.Item>
                <LabeledList.Item label="Think Delay (base)">
                  {formatTime(base_think_delay)}
                </LabeledList.Item>
                <LabeledList.Item label="Next Think At">
                  {formatTime(next_think_time)}
                </LabeledList.Item>
                <LabeledList.Item label="Event Interval">
                  {formatTime(min_event_interval)} —{' '}
                  {formatTime(max_event_interval)}
                </LabeledList.Item>
              </LabeledList>
            </Section>

            <Section title="Current Goal">
              <LabeledList>
                <LabeledList.Item label="Global">
                  {current_global_goal ? (
                    <Box>
                      <b>
                        {current_global_goal.name || current_global_goal.id}
                      </b>
                      {typeof current_global_goal.weight === 'number' ? (
                        <Box opacity={0.6}>
                          Weight: {current_global_goal.weight}
                        </Box>
                      ) : null}
                    </Box>
                  ) : (
                    '—'
                  )}
                </LabeledList.Item>
                <ProgressRow label="Progress" value={global_goal_progress} />
                {typeof global_goal_weight === 'number' ? (
                  <LabeledList.Item label="Weight">
                    {global_goal_weight}
                  </LabeledList.Item>
                ) : null}
                <LabeledList.Item label="Subgoal">
                  {current_subgoal ? (
                    <b>{current_subgoal.name || current_subgoal.id}</b>
                  ) : (
                    '—'
                  )}
                </LabeledList.Item>
              </LabeledList>

              <Stack mt={1} wrap>
                <Stack.Item>
                  <Button icon="play" onClick={() => act('force_think')}>
                    Think Now
                  </Button>
                </Stack.Item>
                <Stack.Item>
                  <Button
                    icon="bolt"
                    disabled={!can_force_event}
                    onClick={() => act('trigger_event')}
                  >
                    Trigger Event
                  </Button>
                </Stack.Item>
                <Stack.Item>
                  <Button.Confirm
                    color="red"
                    icon="trash"
                    onClick={() => act('clear_goal')}
                  >
                    Clear Goal
                  </Button.Confirm>
                </Stack.Item>
                <Stack.Item>
                  <Button
                    icon="flag-checkered"
                    onClick={() => act('complete_goal')}
                  >
                    Complete Goal
                  </Button>
                </Stack.Item>
              </Stack>
            </Section>

            <Section title="Recent Events">
              {recent_events.length ? (
                <LabeledList>
                  {recent_events
                    .slice(-10)
                    .reverse()
                    .map((ev, i) => (
                      <LabeledList.Item key={i} label={formatTime(ev.time)}>
                        {ev.desc}
                      </LabeledList.Item>
                    ))}
                </LabeledList>
              ) : (
                <Box opacity={0.6}>No events recorded.</Box>
              )}
            </Section>
          </>
        )}

        {tab === 'goals' && (
          <>
            <Section title="Select Global Goal">
              <Stack>
                <Stack.Item grow>
                  <Dropdown
                    selected={selectedGoal}
                    onSelected={(v) => setSelectedGoal(String(v))}
                    options={available_goals.map((g) => g.name || g.id)}
                    placeholder="Select a goal..."
                    width="100%"
                  />
                </Stack.Item>
                <Stack.Item>
                  <Button
                    icon="check"
                    disabled={!selectedGoal}
                    onClick={() => {
                      const goal = available_goals.find(
                        (g) => (g.name || g.id) === selectedGoal,
                      );
                      if (goal) {
                        act('set_global_goal', { id: goal.id });
                      }
                    }}
                  >
                    Set Goal
                  </Button>
                </Stack.Item>
                <Stack.Item>
                  <Button icon="random" onClick={() => act('reroll_goal')}>
                    Reroll
                  </Button>
                </Stack.Item>
              </Stack>
            </Section>

            <Section title="Subgoal">
              <LabeledList>
                <LabeledList.Item label="Current">
                  {current_subgoal ? (
                    <b>{current_subgoal.name || current_subgoal.id}</b>
                  ) : (
                    '—'
                  )}
                </LabeledList.Item>
              </LabeledList>
              <Stack mt={1} wrap>
                <Stack.Item>
                  <Button
                    icon="chevron-up"
                    onClick={() => act('promote_subgoal')}
                  >
                    Promote to Global
                  </Button>
                </Stack.Item>
                <Stack.Item>
                  <Button
                    icon="step-forward"
                    onClick={() => act('next_subgoal')}
                  >
                    Next Subgoal
                  </Button>
                </Stack.Item>
              </Stack>
            </Section>
          </>
        )}

        {tab === 'settings' && (
          <>
            <Section title="Mood & Pace">
              <LabeledList>
                <LabeledList.Item label="Mood">
                  <Stack>
                    <Stack.Item grow>
                      <Dropdown
                        selected={selectedMood}
                        onSelected={(v) => setSelectedMood(String(v))}
                        options={available_moods.map((m) => ({
                          value: m.id,
                          displayText: m.name,
                        }))}
                        placeholder="Select a mood..."
                        width="100%"
                      />
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon="check"
                        disabled={!selectedMood}
                        onClick={() => act('set_mood', { id: selectedMood })}
                      >
                        Set Mood
                      </Button>
                    </Stack.Item>
                  </Stack>
                </LabeledList.Item>
                <LabeledList.Item label="Pace Multiplier">
                  <Stack>
                    <Stack.Item grow>
                      <Dropdown
                        selected={pace}
                        onSelected={(v) => setPace(String(v))}
                        options={[0.5, 0.75, 1, 1.25, 1.5, 2].map((v) =>
                          String(v),
                        )}
                        placeholder="Select pace..."
                        width="100%"
                      />
                    </Stack.Item>
                    <Stack.Item>
                      <Button
                        icon="check"
                        onClick={() =>
                          act('set_pace', { pace: Number(pace) || 1 })
                        }
                      >
                        Apply Pace
                      </Button>
                    </Stack.Item>
                  </Stack>
                </LabeledList.Item>
              </LabeledList>
            </Section>

            <Section title="Planning">
              <Stack wrap>
                <Stack.Item>
                  <Button icon="refresh" onClick={() => act('reanalyse')}>
                    Reanalyse Station
                  </Button>
                </Stack.Item>
                <Stack.Item>
                  <Button icon="calendar" onClick={() => act('replan')}>
                    Replan Goals
                  </Button>
                </Stack.Item>
              </Stack>
            </Section>
          </>
        )}
      </Window.Content>
    </Window>
  );
};
