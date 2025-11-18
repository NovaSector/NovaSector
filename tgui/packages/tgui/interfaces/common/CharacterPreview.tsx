import { ByondUi } from 'tgui-core/components';

export const CharacterPreview = (props: {
  width?: string; // NOVA EDIT
  height: string;
  id: string;
}) => {
  // NOVA EDIT
  const { width = '220px' } = props;
  // NOVA EDIT END
  return (
    <ByondUi
      width={width} // NOVA EDIT
      height={props.height}
      params={{
        id: props.id,
        type: 'map',
      }}
    />
  );
};
