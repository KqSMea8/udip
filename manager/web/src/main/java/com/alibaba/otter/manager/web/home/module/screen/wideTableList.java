/*
 * Copyright (C) 2010-2101 Alibaba Group Holding Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.alibaba.otter.manager.web.home.module.screen;

import com.alibaba.citrus.turbine.Context;
import com.alibaba.citrus.turbine.dataresolver.Param;
import com.alibaba.citrus.util.Paginator;
import com.alibaba.otter.manager.biz.config.widetable.WideTableService;
import com.alibaba.otter.manager.web.common.model.SeniorDataMediaSource;
import com.alibaba.otter.shared.common.model.config.data.WideTable;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class wideTableList {


    @Resource(name = "wideTableService")
    private WideTableService wideTableService;

    public void execute(@Param("pageIndex") int pageIndex, @Param("searchKey") String searchKey, Context context)
                                                                                                                 throws Exception {
        @SuppressWarnings("unchecked")
        Map<String, Object> condition = new HashMap<String, Object>();
        if ("请输入关键字".equals(searchKey)) {
            searchKey = "";
        }
        condition.put("searchKey", searchKey);

        int count = wideTableService.getCount(condition);
        Paginator paginator = new Paginator();
        paginator.setItems(count);
        paginator.setPage(pageIndex);

        condition.put("offset", paginator.getOffset());
        condition.put("length", paginator.getLength());


        List<WideTable> wideTableList = wideTableService.listByCondition(condition);
        List<SeniorDataMediaSource> seniorDataMediaSources = new ArrayList<SeniorDataMediaSource>();


        context.put("wideTableList", wideTableList);
        context.put("paginator", paginator);
        context.put("searchKey", searchKey);
    }
}
