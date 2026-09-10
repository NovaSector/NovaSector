// THIS IS A NOVA SECTOR UI FILE

import { useBackend } from 'tgui/backend';
import {
  Box,
  Button,
  Floating,
  Icon,
} from 'tgui-core/components';

import type {
  Job,
  PreferencesMenuData,
} from '../types';

import { useServerPrefs } from '../useServerPrefs';

type JobTitleProps = {
  job: Job;
  name: string;
};

export function JobTitle(props: JobTitleProps) {
  const { job, name } = props;
  const { act, data } = useBackend<PreferencesMenuData>();
   const serverData = useServerPrefs();

  const altTitleSelected = data.job_alt_titles?.[name] ?? name;
  const departmentColor =
    serverData?.jobs.departments[job.department]?.color ?? 'grey';

  if (!job.alt_titles?.length) {
    return <>{name}</>;
  }

  return (
    <Floating
      placement="bottom-start"
      stopChildPropagation
      content={
        <Box
          className="PreferencesMenu__Jobs__altTitleMenu"
          style={
            {
              '--department-color': departmentColor,
            } as React.CSSProperties
          }
        >
        {job.alt_titles.map((title) => (
          <Button
            key={title}
            fluid
            color="transparent"
            selected={title === altTitleSelected}
            onClick={() => act('set_job_title', { job: name, new_title: title })}
          >
            {title}
          </Button>
        ))}
      </Box>
    }
    >
      <Box as="span" style={{ cursor: 'pointer', display: 'flex', alignItems: 'center' }}>
        <Box style={{ flex: 1, minWidth: 0 }}>
          {altTitleSelected}
        </Box>
      <Icon name="caret-down" ml={0.5} style={{ opacity: 0.45 }} />
    </Box>
    </Floating>
  );
}
