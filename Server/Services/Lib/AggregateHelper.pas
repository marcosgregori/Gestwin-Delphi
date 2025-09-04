unit AggregateHelper;

interface

uses  SynCommons,
      Variants;

procedure _RecalculateGroupCountAndSummary( var dataItem  : Variant; groupInfo : Variant );

implementation

uses ServerUtils;

const MIN_OP = 'MIN';
      MAX_OP = 'MAX';
      AVG_OP = 'AVG';
      COUNT_OP = 'COUNT';
      AS_OP = 'AS';
      GENERATED_FIELD_PREFIX = 'dx_';

procedure _RecalculateGroupCountAndSummary( var dataItem  : Variant;
                                                groupInfo : Variant );

var grInfo : Variant;

begin
      If   groupInfo.groupIndex <= groupInfo.groupCount - 3
      then begin
           var items := DocVariantData( dataItem.items );
           For var Inx := 0 to items.Count - 1 do
             begin
             DocVariantData( grInfo ).InitCopy( groupInfo, DEF_JSON_OPTIONS );
             grInfo.groupIndex := grInfo.groupIndex + 1;
             _RecalculateGroupCountAndSummary( items.Values[ Inx ], grInfo );
             end;
           end;

      If   not VarIsNull( groupInfo.summaryTypes ) and ( groupInfo.groupIndex < groupInfo.groupCount - 2 )
      then begin

           var outcome := _Arr( [] );
           var items := DocVariantData( dataItem.items );
           var itemsCount := items.Count;
           var summaryTypes := DocVariantData( groupInfo.summaryTypes );

           For var index := 0 to items.Count - 1 do
             begin

             var item := items.Values[ index ];
             var currentSummaries := DocVariantData( item.summary );
             If   index=0
             then begin
                  For var si := 0 to currentSummaries.Count - 1 do
                     outcome := outcome + currentSummaries.Values[ si ];
                  Continue;
                  end;

             For var si := 0 to summaryTypes.Count - 1 do
               begin
               var stItem := summaryTypes.Values[ si ];
               If   stItem=MIN_OP
               then begin
                    If   outcome[ si ]>currentSummaries.Values[ si ]
                    then outcome[ si ] := currentSummaries.Values[ si ];
                    Continue;
                    end;
               If   stItem=MAX_OP
               then begin
                    If   outcome[ si ]<currentSummaries.Values[ si ]
                    then outcome[ si ] := currentSummaries.Values[ si ];
                    Continue;
                    end;
               outcome[ si ] := outcome[ si ] + currentSummaries.Values[ si ];
               end;

             end;

           For var si := 0 to summaryTypes.Count -1 do
             If   summaryTypes.Values[ si ]=AVG_OP
             then outcome[ si ] := outcome[ si ] / itemsCount;

           dataItem.summary := outcome;
           end;

    end;

function _GetNewDataItem( row, groupInfo : Variant ) : Variant;
begin
     var dataItem := _Arr( [] );
     var dataFieldCount := groupInfo.dataFieldNames.Count;
     For Var Index : SmallInt := 0 to dataFieldCount - 1 do
        dataItem.Values[ groupInfo.dataFieldNames.Values[ Index ] ] := row.Values[ groupInfo.groupCount + $index];
     Result := dataItem;
end;
    private static function _GetNewGroupItem($row, $groupInfo) {
        $groupIndexOffset = $groupInfo['lastGroupExpanded'] ? 1 : 2;
        $groupItem = array();
        $groupItem['key'] = $row[$groupInfo['groupIndex']];
        $groupItem['items'] = $groupInfo['groupIndex'] < $groupInfo['groupCount'] - $groupIndexOffset ? array() :
                                                                                                          ($groupInfo['lastGroupExpanded'] ? array() : NULL);
        if ($groupInfo['groupIndex'] == $groupInfo['groupCount'] - $groupIndexOffset) {
            if (isset($groupInfo['summaryTypes'])) {
                $summaries = array();
                $endIndex = $groupInfo['groupIndex'] + count($groupInfo['summaryTypes']) + 1;
                for ($index = $groupInfo['groupCount']; $index <= $endIndex; $index++) {
                    $summaries[] = $row[$index];
                }
                $groupItem['summary'] = $summaries;
            }
            if (!$groupInfo['lastGroupExpanded']) {
                $groupItem['count'] = $row[$groupInfo['groupIndex'] + 1];
            }
            else {
                $groupItem['items'][] = self::_GetNewDataItem($row, $groupInfo);
            }
        }
        return $groupItem;
    }
    private static function _GroupData($row, &$resultItems, $groupInfo) {
        $itemsCount = count($resultItems);
        if (!isset($row) && !$itemsCount) {
            return;
        }
        $currentItem = NULL;
        $groupIndexOffset = $groupInfo['lastGroupExpanded'] ? 1 : 2;
        if ($itemsCount) {
            $currentItem = &$resultItems[$itemsCount - 1];
            if (!$groupInfo['lastGroupExpanded']) {
                if ($currentItem['key'] != $row[$groupInfo['groupIndex']] || !isset($row)) {
                    if ($groupInfo['groupIndex'] == 0 && $groupInfo['groupCount'] > 2) {
                        self::_RecalculateGroupCountAndSummary($currentItem, $groupInfo);
                    }
                    unset($currentItem);
                    if (!isset($row)) {
                        return;
                    }
                }
            }
            else {
                if ($currentItem['key'] != $row[$groupInfo['groupIndex']]) {
                    unset($currentItem);
                }
                else {
                    if ($groupInfo['groupIndex'] == $groupInfo['groupCount'] - $groupIndexOffset) {
                        $currentItem['items'][] = self::_GetNewDataItem($row, $groupInfo);
                    }
                }
            }
        }
        if (!isset($currentItem)) {
            $currentItem = self::_GetNewGroupItem($row, $groupInfo);
            $resultItems[] = &$currentItem;
        }
        if ($groupInfo['groupIndex'] < $groupInfo['groupCount'] - $groupIndexOffset) {
            $groupInfo['groupIndex']++;
            self::_GroupData($row, $currentItem['items'], $groupInfo);
        }
    }
    public static function GetGroupedDataFromQuery($queryResult, $groupSettings) {
        $result = array();
        $row = NULL;
        $groupSummaryTypes = NULL;
        $dataFieldNames = NULL;
        $startSummaryFieldIndex = NULL;
        $endSummaryFieldIndex = NULL;
        if ($groupSettings['lastGroupExpanded']) {
            $queryFields = $queryResult->fetch_fields();
            $dataFieldNames = array();
            for ($i = $groupSettings['groupCount']; $i < count($queryFields); $i++) {
                $dataFieldNames[] = $queryFields[$i]->name;
            }
        }
        if (isset($groupSettings['summaryTypes'])) {
            $groupSummaryTypes = $groupSettings['summaryTypes'];
            $startSummaryFieldIndex = $groupSettings['groupCount'] - 1;
            $endSummaryFieldIndex = $startSummaryFieldIndex + count($groupSummaryTypes);
        }
        $groupInfo = array(
            'groupCount' => $groupSettings['groupCount'],
            'groupIndex' => 0,
            'summaryTypes' => $groupSummaryTypes,
            'lastGroupExpanded' => $groupSettings['lastGroupExpanded'],
            'dataFieldNames' => $dataFieldNames
        );
        while ($row = $queryResult->fetch_array(MYSQLI_NUM)) {
            if (isset($startSummaryFieldIndex)) {
                for ($i = $startSummaryFieldIndex; $i <= $endSummaryFieldIndex; $i++) {
                    $row[$i] = Utils::StringToNumber($row[$i]);
                }
            }
            self::_GroupData($row, $result, $groupInfo);
        }
        if (!$groupSettings['lastGroupExpanded']) {
            self::_GroupData($row, $result, $groupInfo);
        }
        else {
            if (isset($groupSettings['skip']) && $groupSettings['skip'] >= 0 &&
                isset($groupSettings['take']) && $groupSettings['take'] >= 0) {
                $result = array_slice($result, $groupSettings['skip'], $groupSettings['take']);
            }
        }
        return $result;
    }
    public static function IsLastGroupExpanded($items) {
        $result = true;
        $itemsCount = count($items);
        if ($itemsCount > 0) {
            $lastItem = $items[$itemsCount - 1];
            if (gettype($lastItem) === 'object') {
                $result = isset($lastItem->isExpanded) ? $lastItem->isExpanded === true : true;
            }
            else {
                $result = true;
            }
        }
        return $result;
    }
    public static function GetFieldSetBySelectors($items) {
        $group = '';
        $sort = '';
        $select = '';
        foreach ($items as $item) {
            $groupField = NULL;
            $sortField = NULL;
            $selectField = NULL;
            $desc = false;
            if (is_string($item) && strlen($item = trim($item))) {
                $selectField = $groupField = $sortField = Utils::QuoteStringValue($item);
            }
            else if (gettype($item) === 'object' && isset($item->selector)) {
                $quoteSelector = Utils::QuoteStringValue($item->selector);
                $desc = isset($item->desc) ? $item->desc : false;
                if (isset($item->groupInterval)) {
                    if (is_int($item->groupInterval)) {
                        $groupField = Utils::QuoteStringValue(sprintf('%s%s_%d', self::GENERATED_FIELD_PREFIX, $item->selector, $item->groupInterval));
                        $selectField = sprintf('(%s - (%s %% %d)) %s %s',
                                               $quoteSelector,
                                               $quoteSelector,
                                               $item->groupInterval,
                                               self::AS_OP,
                                               $groupField);
                    }
                    else {
                        $groupField = Utils::QuoteStringValue(sprintf('%s%s_%s', self::GENERATED_FIELD_PREFIX, $item->selector, $item->groupInterval));
                        $selectField = sprintf('%s(%s) %s %s',
                                               strtoupper($item->groupInterval),
                                               $quoteSelector,
                                               self::AS_OP,
                                               $groupField);
                    }
                    $sortField = $groupField;
                }
                else {
                    $selectField = $groupField = $sortField = $quoteSelector;
                }
            }
            if (isset($selectField)) {
                $select .= (strlen($select) > 0 ? ', '.$selectField : $selectField);
            }
            if (isset($groupField)) {
                $group .= (strlen($group) > 0 ? ', '.$groupField : $groupField);
            }
            if (isset($sortField)) {
                $sort .= (strlen($sort) > 0 ? ', '.$sortField : $sortField).
                         ($desc ? ' DESC' : '');
            }
        }
        return array(
            'group' => $group,
            'sort' => $sort,
            'select' => $select
        );
    }
    public static function GetSummaryInfo($expression) {
        $result = array();
        $fields = '';
        $summaryTypes = array();
        foreach ($expression as $index => $item) {
            if (gettype($item) === 'object' && isset($item->summaryType)) {
                $summaryTypes[] = strtoupper($item->summaryType);
                $fields .= sprintf('%s(%s) %s %sf%d',
                                   strlen($fields) > 0 ? ', '.$summaryTypes[$index] : $summaryTypes[$index],
                                   (isset($item->selector) && is_string($item->selector)) ? Utils::QuoteStringValue($item->selector) : '1',
                                   self::AS_OP,
                                   self::GENERATED_FIELD_PREFIX,
                                   $index);
            }
        }
        $result['fields'] = $fields;
        $result['summaryTypes'] = $summaryTypes;
        return $result;
    }
}
*)

end.