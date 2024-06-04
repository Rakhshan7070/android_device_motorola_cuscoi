#=============================================================================
# Copyright (c) 2020-2023 Qualcomm Technologies, Inc.
# All Rights Reserved.
# Confidential and Proprietary - Qualcomm Technologies, Inc.
#
# Copyright (c) 2014-2017, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#=============================================================================

enable_tracing_events()
{
    # sound
    echo 1 > /sys/kernel/tracing/events/asoc/snd_soc_reg_read/enable
    echo 1 > /sys/kernel/tracing/events/asoc/snd_soc_reg_write/enable
    # mdp
    echo 1 > /sys/kernel/tracing/events/mdss/mdp_video_underrun_done/enable
    # video
    echo 1 > /sys/kernel/tracing/events/msm_vidc/enable
    # power
    echo 1 > /sys/kernel/tracing/events/msm_low_power/enable
    # fastrpc
    echo 1 > /sys/kernel/tracing/events/fastrpc/enable
    # EMMC FTRACE
    echo 1 > /sys/kernel/tracing/events/mmc/mmc_request_start/enable
    echo 1 > /sys/kernel/tracing/events/mmc/mmc_request_done/enable
    #enable trace
    echo 1 > /sys/kernel/tracing/tracing_on
}

# function to enable ftrace events
enable_ftrace_event_tracing()
{
    # bail out if its perf config
    if [ ! -d /sys/module/msm_rtb ]
    then
        return
    fi

    # bail out if ftrace events aren't present
    if [ ! -d /sys/kernel/tracing/events ]
    then
        return
    fi

    enable_tracing_events
}

enable_memory_debug()
{
    # bail out if its perf config
    if [ ! -d /sys/module/msm_rtb ]
    then
        return
    fi

}

# function to enable ftrace event transfer to CoreSight STM
enable_stm_events()
{
    # bail out if its perf config
    if [ ! -d /sys/module/msm_rtb ]
    then
        return
    fi
    # bail out if coresight isn't present
    if [ ! -d /sys/bus/coresight ]
    then
        return
    fi
    # bail out if ftrace events aren't present
    if [ ! -d /sys/kernel/tracing/events ]
    then
        return
    fi

    echo $etr_size > /sys/bus/coresight/devices/coresight-tmc-etr/buffer_size
    echo 1 > /sys/bus/coresight/devices/coresight-tmc-etr/$sinkenable
    echo coresight-stm > /sys/class/stm_source/ftrace/stm_source_link
    echo 1 > /sys/bus/coresight/devices/coresight-stm/$srcenable
    echo 0 > /sys/bus/coresight/devices/coresight-stm/hwevent_enable
}
enable_lpm_with_dcvs_tracing()
{
    # "Configure CPUSS LPM Debug events"
    echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss/reset
    echo 1 > /sys/bus/coresight/devices/coresight-tpdm-actpm/reset
    echo 0x0 0x0 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x0 0x0 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x1 0x1 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x1 0x1 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x2 0x2 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x2 0x2 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x3 0x3 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x3 0x3 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x1d 0x1d 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x1d 0x1d 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x1e 0x1e 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x1e 0x1e 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x1f 0x1f 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x1f 0x1f 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x20 0x20 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x20 0x20 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x40 0x40 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x40 0x40 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x41 0x41 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x41 0x41 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x42 0x42 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x42 0x42 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x43 0x43 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x43 0x43 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x5d 0x5d 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x5d 0x5d 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x5e 0x5e 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x5e 0x5e 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x5f 0x5f 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x5f 0x5f 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x60 0x60 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x60 0x60 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x80 0x80 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x80 0x80 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x81 0x81 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x81 0x81 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x82 0x82 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x82 0x82 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x83 0x83 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x83 0x83 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x91 0x91 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x91 0x91 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x92 0x92 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x92 0x92 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x93 0x93 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x93 0x93 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x94 0x94 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x94 0x94 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x95 0x95 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x95 0x95 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x96 0x96 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x96 0x96 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x97 0x97 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x97 0x97 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x98 0x98 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x98 0x98 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x99 0x99 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x99 0x99 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x9a 0x9a 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x9a 0x9a 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x9d 0x9d 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x9d 0x9d 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x9e 0x9e 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x9e 0x9e 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0x9f 0x9f 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0x9f 0x9f 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0xa0 0xa0 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0xa0 0xa0 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0xa1 0xa1 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0xa1 0xa1 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0xc0 0xc0 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0xc0 0xc0 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0xc1 0xc1 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0xc1 0xc1 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0xc2 0xc2 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0xc2 0xc2 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0xc3 0xc3 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0xc3 0xc3 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0xdd 0xdd 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0xdd 0xdd 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0xde 0xde 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0xde 0xde 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0xdf 0xdf 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0xdf 0xdf 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0xe0 0xe0 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0xe0 0xe0 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0xfb 0xfb 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0xfb 0xfb 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0xff 0xff 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
    echo 0xff 0xff 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
    echo 0 0x00006666  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 3 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 4 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 8 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 11 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 12 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 16 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 18 0x11111110  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 19 0x00000111  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 20 0x00000066  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 24 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 27 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 28 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 31 0x70007000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
    echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_ts
    echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_type
    echo 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_trig_ts
    echo 0 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
    echo 1 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
    echo 2 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
    echo 3 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
    echo 4 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
    echo 5 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
    echo 6 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
    echo 7 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask

    # "Configure CPUCP Trace and Debug Bus ACTPM "
    echo 0 0x20 > /sys/bus/coresight/devices/coresight-tpdm-actpm/cmb_msr
    echo 0 > /sys/bus/coresight/devices/coresight-tpdm-actpm/mcmb_lanes_select
    echo 1 0 > /sys/bus/coresight/devices/coresight-tpdm-actpm/cmb_mode
    echo 1 > /sys/bus/coresight/devices/coresight-tpdm-actpm/cmb_ts_all
    echo 1 > /sys/bus/coresight/devices/coresight-tpdm-actpm/cmb_patt_ts
    echo 0 0x20000000 > /sys/bus/coresight/devices/coresight-tpdm-actpm/cmb_patt_mask
    echo 0 0x20000000 > /sys/bus/coresight/devices/coresight-tpdm-actpm/cmb_patt_val
    # echo 1 > /sys/bus/coresight/reset_source_sink
    # echo mem > /sys/bus/coresight/devices/coresight-tmc-etr/out_mode
    # echo 1 > /sys/bus/coresight/devices/coresight-tmc-etr/enable_sink

    # "Start Trace collection "
    echo 0x2 > /sys/bus/coresight/devices/coresight-tpdm-apss/enable_datasets
    echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss/enable_source
    echo 0x4 > /sys/bus/coresight/devices/coresight-tpdm-actpm/enable_datasets
    echo 1 > /sys/bus/coresight/devices/coresight-tpdm-actpm/enable_source

}

config_dcc_tsens()
{
    echo 0xc222004 1 > $DCC_PATH/config
    echo 0xc263014 1 > $DCC_PATH/config
    echo 0xc2630e0 1 > $DCC_PATH/config
    echo 0xc2630ec 1 > $DCC_PATH/config
    echo 0xc2630a0 16 > $DCC_PATH/config
    echo 0xc2630e8 1 > $DCC_PATH/config
    echo 0xc26313c 1 > $DCC_PATH/config
    echo 0xc223004 1 > $DCC_PATH/config
    echo 0xc265014 1 > $DCC_PATH/config
    echo 0xc2650e0 1 > $DCC_PATH/config
    echo 0xc2650ec 1 > $DCC_PATH/config
    echo 0xc2650a0 16 > $DCC_PATH/config
    echo 0xc2650e8 1 > $DCC_PATH/config
    echo 0xc26513c 1 > $DCC_PATH/config
}

config_dcc_core() {
    # core hang
    echo 0x1780005c 1 > $DCC_PATH/config
    echo 0x1781005c 1 > $DCC_PATH/config
    echo 0x1782005c 1 > $DCC_PATH/config
    echo 0x1783005c 1 > $DCC_PATH/config
    echo 0x1784005c 1 > $DCC_PATH/config
    echo 0x1785005c 1 > $DCC_PATH/config
    echo 0x1786005c 1 > $DCC_PATH/config
    echo 0x1787005c 1 > $DCC_PATH/config
    echo 0x1740003c 1 > $DCC_PATH/config

    #MIBU Debug registers
    echo 0x17600238 1 > $DCC_PATH/config
    echo 0x17600240 11 > $DCC_PATH/config

    #CHI (GNOC) Hang counters
    echo 0x17600404 1 > $DCC_PATH/config
    echo 0x1760041c 2 > $DCC_PATH/config
    echo 0x17600434 1 > $DCC_PATH/config
    echo 0x1760043c 2 > $DCC_PATH/config

    #SYSCO and other misc debug
    echo 0x17400438 1 > $DCC_PATH/config
    echo 0x17600044 1 > $DCC_PATH/config
    echo 0x17600500 1 > $DCC_PATH/config

    #PPUHWSTAT_STS
    echo 0x17600504 5 > $DCC_PATH/config

    #CPRh
    echo 0x17900908 1 > $DCC_PATH/config
    echo 0x17900c18 1 > $DCC_PATH/config
    #echo 0x17901c18 1 > $DCC_PATH/config
    #echo 0x17b90810 1 > $DCC_PATH/config
    #echo 0x17b90814 1 > $DCC_PATH/config
    #echo 0x17b90818 1 > $DCC_PATH/config
    #echo 0x17b93a84 1 > $DCC_PATH/config
    echo 0x17ba0810 1 > $DCC_PATH/config
    echo 0x17ba0c50 1 > $DCC_PATH/config
    echo 0x17ba0814 1 > $DCC_PATH/config
    echo 0x17ba0c54 1 > $DCC_PATH/config
    echo 0x17ba0818 1 > $DCC_PATH/config
    echo 0x17ba0c58 1 > $DCC_PATH/config
    echo 0x17ba3a84 2 > $DCC_PATH/config
    #echo 0x17b93500 40 > $DCC_PATH/config
    echo 0x17ba3500 40 > $DCC_PATH/config

    #Silver,Gold,L3 PLL
    echo 0x17a80000 16 > $DCC_PATH/config
    echo 0x17a82000 6 > $DCC_PATH/config
    echo 0x17a84000 16 > $DCC_PATH/config
    echo 0x17a86000 6 > $DCC_PATH/config
    echo 0x17a88000 16 > $DCC_PATH/config
    echo 0x17a8a000 6 > $DCC_PATH/config

    #rpmh
    echo 0xc201244 1 > $DCC_PATH/config
    echo 0xc202244 1 > $DCC_PATH/config
    echo 0x17b00000 1 > $DCC_PATH/config

    #L3-ACD
    echo 0x17a94030 1 > $DCC_PATH/config
    echo 0x17a9408c 1 > $DCC_PATH/config
    echo 0x17a9409c 0x78 > $DCC_PATH/config_write
    echo 0x17a9409c 0x0 > $DCC_PATH/config_write
    echo 0x17a94048 0x1 > $DCC_PATH/config_write
    echo 0x17a94090 0x0 > $DCC_PATH/config_write
    echo 0x17a94090 0x25 > $DCC_PATH/config_write
    echo 0x17a94098 1 > $DCC_PATH/config
    echo 0x17a94048 0x1D > $DCC_PATH/config_write
    echo 0x17a94090 0x0 > $DCC_PATH/config_write
    echo 0x17a94090 0x25 > $DCC_PATH/config_write
    echo 0x17a94098 1 > $DCC_PATH/config

    #SILVER-ACD
    echo 0x17a90030 1 > $DCC_PATH/config
    echo 0x17a9008c 1 > $DCC_PATH/config
    echo 0x17a9009c 0x78 > $DCC_PATH/config_write
    echo 0x17a9009c 0x0 > $DCC_PATH/config_write
    echo 0x17a90048 0x1 > $DCC_PATH/config_write
    echo 0x17a90090 0x0 > $DCC_PATH/config_write
    echo 0x17a90090 0x25 > $DCC_PATH/config_write
    echo 0x17a90098 1 > $DCC_PATH/config
    echo 0x17a90048 0x1D > $DCC_PATH/config_write
    echo 0x17a90090 0x0 > $DCC_PATH/config_write
    echo 0x17a90090 0x25 > $DCC_PATH/config_write
    echo 0x17a90098 1 > $DCC_PATH/config


    #GOLD-ACD
    echo 0x17a92030 1 > $DCC_PATH/config
    echo 0x17a9208c 1 > $DCC_PATH/config
    echo 0x17a9209c 0x78 > $DCC_PATH/config_write
    echo 0x17a9209c 0x0 > $DCC_PATH/config_write
    echo 0x17a92048 0x1 > $DCC_PATH/config_write
    echo 0x17a92090 0x0 > $DCC_PATH/config_write
    echo 0x17a92090 0x25 > $DCC_PATH/config_write
    echo 0x17a92098 1 > $DCC_PATH/config
    echo 0x17a92048 0x1D > $DCC_PATH/config_write
    echo 0x17a92090 0x0 > $DCC_PATH/config_write
    echo 0x17a92090 0x25 > $DCC_PATH/config_write
    echo 0x17a92098 1 > $DCC_PATH/config

    #Security Control Core for Binning info
    echo 0x221C20A4 1 > $DCC_PATH/config
    echo 0x221c21c4 1 > $DCC_PATH/config

    #SoC version
    echo 0x1fc8000 1 > $DCC_PATH/config

    #WDOG BIT Config
    echo 0x17400038 1 > $DCC_PATH/config

    #Curr Freq
    echo 0x17d91020 1 > $DCC_PATH/config
    echo 0x17d92020 1 > $DCC_PATH/config
    echo 0x17d90020 1 > $DCC_PATH/config

    #OSM Seq curr addr
    echo 0x17d9134c 1 > $DCC_PATH/config
    echo 0x17d9234c 1 > $DCC_PATH/config
    echo 0x17d9034c 1 > $DCC_PATH/config

    #DCVS_IN_PROGRESS
    echo 0x17d91300 1 > $DCC_PATH/config
    echo 0x17d92300 1 > $DCC_PATH/config
    echo 0x17d90300 1 > $DCC_PATH/config

    #silver LLM
    echo 0x17B784A0 12 > $DCC_PATH/config
    echo 0x17B78520 1 > $DCC_PATH/config
    echo 0x17B78588 1 > $DCC_PATH/config
    echo 0x17B78D90 8 > $DCC_PATH/config
    echo 0x17B79010 6 > $DCC_PATH/config
    echo 0x17B79090 6 > $DCC_PATH/config
    echo 0x17B79A90 4 > $DCC_PATH/config

    # gold LLM
    # echo 0x17B70220 2 > $DCC_PATH/config
    # echo 0x17B702A0 2 > $DCC_PATH/config
    # echo 0x17B704A0 12 > $DCC_PATH/config
    # echo 0x17B70520 1 > $DCC_PATH/config
    # echo 0x17B70588 1 > $DCC_PATH/config
    # echo 0x17B70D90 12 > $DCC_PATH/config
    # echo 0x17B71010 10 > $DCC_PATH/config
    # echo 0x17B71090 10 > $DCC_PATH/config
    # echo 0x17B71A90 8 > $DCC_PATH/config
}

config_dcc_smmu(){
    echo 0x15002204 1 > $DCC_PATH/config
    echo 0x150022F8 2 > $DCC_PATH/config
    echo 0x15002300 2 > $DCC_PATH/config
    echo 0x150025DC 1 > $DCC_PATH/config
    echo 0x15002648 1 > $DCC_PATH/config
    echo 0x15002670 1 > $DCC_PATH/config
    echo 0x150055DC 1 > $DCC_PATH/config
    echo 0x150075DC 1 > $DCC_PATH/config
}

gemnoc_dump() {
    #; gem_noc_qns_mc0_poc_err
    echo 0x19100010 1 > $DCC_PATH/config
    echo 0x19100020 6 > $DCC_PATH/config

    #; gem_noc_qns_mc1_poc_err
    echo 0x19140010 1 > $DCC_PATH/config
    echo 0x19140020 6 > $DCC_PATH/config

    #; gem_noc_qns_cnoc_poc_err
    echo 0x19180010 1 > $DCC_PATH/config
    echo 0x19180020 6 > $DCC_PATH/config

    #; gem_noc_qns_pcie_poc_err
    echo 0x19180410 1 > $DCC_PATH/config
    echo 0x19180420 6 > $DCC_PATH/config

    #; gem_noc_fault_sbm_FaultInStatus0_Low
    echo 0x19180848 1 > $DCC_PATH/config
    #; gem_noc_qns_mc0_poc_dbg_Cfg_Low
    echo 0x19120008 1 > $DCC_PATH/config
    #; gem_noc_qns_mc0_poc_dbg_Cfg_High
    echo 0x1912000C 1 > $DCC_PATH/config
    #; gem_noc_qns_mc1_poc_dbg_Cfg_Low
    echo 0x19160008 1 > $DCC_PATH/config
    #; gem_noc_qns_mc1_poc_dbg_Cfg_High
    echo 0x1916000C 1 > $DCC_PATH/config
    #; gem_noc_qns_cnoc_poc_dbg_Cfg_Low
    echo 0x191B0008 1 > $DCC_PATH/config
    #; gem_noc_qns_cnoc_poc_dbg_Cfg_High
    echo 0x191B000C 1 > $DCC_PATH/config
    #; gem_noc_qns_pcie_poc_dbg_Cfg_Low
    echo 0x191B0408 1 > $DCC_PATH/config
    #; gem_noc_qns_pcie_poc_dbg_Cfg_High
    echo 0x191B040C 1 > $DCC_PATH/config

    #; Non Coherent sys chain
    echo 0x191B1080 1 > $DCC_PATH/config
    echo 0x191B1084 1 > $DCC_PATH/config
    echo 0x191B1088 1 > $DCC_PATH/config
    echo 0x9 > $DCC_PATH/loop
    echo 0x191B1090 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x191B1098 1 > $DCC_PATH/config

    #; Non coherent odd chain
    echo 0x19161080 1 > $DCC_PATH/config
    echo 0x19161084 1 > $DCC_PATH/config
    echo 0x19161088 1 > $DCC_PATH/config
    echo 0x4 > $DCC_PATH/loop
    echo 0x19161090 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x19161098 1 > $DCC_PATH/config

    #; Non coherent even chain
    echo 0x19121080 1 > $DCC_PATH/config
    echo 0x19121084 1 > $DCC_PATH/config
    echo 0x19121088 1 > $DCC_PATH/config
    echo 0x4 > $DCC_PATH/loop
    echo 0x19121090 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x19121098 1 > $DCC_PATH/config

    #; Coherent sys chain
    echo 0x191B1000 1 > $DCC_PATH/config
    echo 0x191B1004 1 > $DCC_PATH/config
    echo 0x191B1008 1 > $DCC_PATH/config
    echo 0x3 > $DCC_PATH/loop
    echo 0x191B1010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x191B1018 1 > $DCC_PATH/config

    #; coherent even chain
    echo 0x19121000 1 > $DCC_PATH/config
    echo 0x19121004 1 > $DCC_PATH/config
    echo 0x19121008 1 > $DCC_PATH/config
    echo 0x2 > $DCC_PATH/loop
    echo 0x19121010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x19121018 1 > $DCC_PATH/config

    #; coherent odd chain
    echo 0x19161000 1 > $DCC_PATH/config
    echo 0x19161004 1 > $DCC_PATH/config
    echo 0x19161008 1 > $DCC_PATH/config
    echo 0x2 > $DCC_PATH/loop
    echo 0x19161010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    echo 0x19161018 1 > $DCC_PATH/config

    #; GEMNOC qosgen registers
    echo 0x19130010 1 > $DCC_PATH/config
    echo 0x19131010 1 > $DCC_PATH/config
    echo 0x19132010 1 > $DCC_PATH/config
    echo 0x19170010 1 > $DCC_PATH/config
    echo 0x19171010 1 > $DCC_PATH/config
    echo 0x19172010 1 > $DCC_PATH/config
    echo 0x191B3010 1 > $DCC_PATH/config
    echo 0x191B5010 1 > $DCC_PATH/config
    echo 0x191B6010 1 > $DCC_PATH/config
    echo 0x191B7010 1 > $DCC_PATH/config
    echo 0x191B8010 1 > $DCC_PATH/config
    echo 0x191B9010 1 > $DCC_PATH/config
    echo 0x191BA010 1 > $DCC_PATH/config
    echo 0x191BB010 1 > $DCC_PATH/config
    echo 0x191BC010 1 > $DCC_PATH/config

     #;gem_noc_qns_mc0_poc_dbg
    echo 0x19120010 1 > $DCC_PATH/config
    #;gem_noc_qns_mc0_poc_dbg_DumpTmoStream
    echo 0x4 > $DCC_PATH/loop
    echo 0x19120030 3 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    #;gem_noc_qns_mc0_poc_dbg_Cfg
    echo 0x19120008 2 > $DCC_PATH/config
    #;gem_noc_qns_mc1_poc_dbg_DumpCxtStream
    echo 0xC6 > $DCC_PATH/loop
    echo 0x19120020 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop

    #;gem_noc_qns_mc1_poc_dbg
    echo 0x19160010 1 > $DCC_PATH/config
    #;gem_noc_qns_mc1_poc_dbg_DumpTmoStream
    echo 0x4 > $DCC_PATH/loop
    echo 0x19160030 3 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    #;gem_noc_qns_mc1_poc_dbg_Cfg
    echo 0x19160008 2 > $DCC_PATH/config
    #;gem_noc_qns_mc1_poc_dbg_DumpCxtStream
    echo 0xC6 > $DCC_PATH/loop
    echo 0x19160020 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop

    #;gem_noc_qns_cnoc_poc_dbg
    echo 0x191B0010 1 > $DCC_PATH/config
    #;gem_noc_qns_cnoc_poc_dbg_DumpTmoStream
    echo 0x4 > $DCC_PATH/loop
    echo 0x191B0030 3 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    #;gem_noc_qns_cnoc_poc_dbg_Cfg
    echo 0x191B0008 2 > $DCC_PATH/config
    #;gem_noc_qns_cnoc_poc_dbg_DumpCxtStream
    echo 0x6A > $DCC_PATH/loop
    echo 0x191B0020 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop

    #;gem_noc_qns_pcie_poc_dbg
    echo 0x191B0410 1 > $DCC_PATH/config
    #;gem_noc_qns_pcie_poc_dbg_DumpTmoStream
    echo 0x4 > $DCC_PATH/loop
    echo 0x191B0430 3 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    #;gem_noc_qns_pcie_poc_dbg_Cfg
    echo 0x191B0408 2 > $DCC_PATH/config
    #;gem_noc_qns_pcie_poc_dbg_DumpCxtStream
    echo 0x66 > $DCC_PATH/loop
    echo 0x191B0420 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    #; GEM_NOC_GRROOM_SBM_SENSEIN
    echo 0x19184100 4 > $DCC_PATH/config
    #;GEM_NOC_SAFE_SHAPING_SBM_SENSEIN
    echo 0x19186100 1 > $DCC_PATH/config
}

config_gpu()
{
    # GCC Registers
    echo 0x181004   > $DCC_PATH/config
    echo 0x181010 5 > $DCC_PATH/config
    echo 0x181154   > $DCC_PATH/config
    echo 0x18b000   > $DCC_PATH/config
    echo 0x18b03c   > $DCC_PATH/config
    echo 0x18c000   > $DCC_PATH/config
    echo 0x18c03c   > $DCC_PATH/config
    echo 0x18d000   > $DCC_PATH/config
    echo 0x18d03c   > $DCC_PATH/config
    echo 0x18e000   > $DCC_PATH/config
    echo 0x18e03c   > $DCC_PATH/config
    echo 0x197000   > $DCC_PATH/config
    echo 0x19703c   > $DCC_PATH/config
    echo 0x18100c   > $DCC_PATH/config

    # GPUCC Registers
    echo 0x3d90000 15 > $DCC_PATH/config
    echo 0x3d91000 15 > $DCC_PATH/config
    echo 0x3d94000 2 > $DCC_PATH/config
    echo 0x3d95000 4 > $DCC_PATH/config
    echo 0x3d96000 4 > $DCC_PATH/config
    echo 0x3d97000 4 > $DCC_PATH/config
    echo 0x3d98000 4 > $DCC_PATH/config
    echo 0x3d99000 6 > $DCC_PATH/config
    echo 0x3d99050 10 > $DCC_PATH/config
    echo 0x3d990a8 2 > $DCC_PATH/config
    echo 0x3d990b0 5 > $DCC_PATH/config
    echo 0x3d990c8 1 > $DCC_PATH/config
    echo 0x3d99104 11 > $DCC_PATH/config
    echo 0x3d99130 10 > $DCC_PATH/config
    echo 0x3d99198 3 > $DCC_PATH/config
    echo 0x3d991e0 3 > $DCC_PATH/config
    echo 0x3d99224 2 > $DCC_PATH/config
    echo 0x3d99274 2 > $DCC_PATH/config
    echo 0x3d99280 3 > $DCC_PATH/config
    echo 0x3d992cc 3 > $DCC_PATH/config
    echo 0x3d99314 3 > $DCC_PATH/config
    echo 0x3d993a0 2 > $DCC_PATH/config
    echo 0x3d993e4 4 > $DCC_PATH/config
    echo 0x3d9942c 2 > $DCC_PATH/config
    echo 0x3d99470 3 > $DCC_PATH/config
    echo 0x3d99500 4 > $DCC_PATH/config
    echo 0x3d99528 23 > $DCC_PATH/config

    # AO Registers
    echo 0x3d8ec0c > $DCC_PATH/config
    echo 0x3d8ec14 2 > $DCC_PATH/config
    echo 0x3d8ec40 4 > $DCC_PATH/config
    echo 0x3d8ec54 > $DCC_PATH/config

    # CX Registers
    echo 0x3d7e648 2 > $DCC_PATH/config
    echo 0x3d7e658 9 > $DCC_PATH/config

    #  Registers
    echo 0x3d00000 1 > $DCC_PATH/config
    echo 0x3d00008 1 > $DCC_PATH/config
    echo 0x3d00044 1 > $DCC_PATH/config
    echo 0x3d00058 6 > $DCC_PATH/config
    echo 0x3d0007c 20 > $DCC_PATH/config
    echo 0x3d000e0 5 > $DCC_PATH/config
    echo 0x3d00108 1 > $DCC_PATH/config
    echo 0x3d00110 1 > $DCC_PATH/config
    echo 0x3d0011c 1 > $DCC_PATH/config
    echo 0x3d00124 2 > $DCC_PATH/config
    echo 0x3d00140 1 > $DCC_PATH/config
    echo 0x3d00158 1 > $DCC_PATH/config
    echo 0x3d002b4 2 > $DCC_PATH/config
    echo 0x3d002c0 1 > $DCC_PATH/config
    echo 0x3d002d0 1 > $DCC_PATH/config
    echo 0x3d002e0 1 > $DCC_PATH/config
    echo 0x3d002f0 1 > $DCC_PATH/config
    echo 0x3d00300 1 > $DCC_PATH/config
    echo 0x3d00310 1 > $DCC_PATH/config
    echo 0x3d00320 1 > $DCC_PATH/config
    echo 0x3d00330 1 > $DCC_PATH/config
    echo 0x3d00340 1 > $DCC_PATH/config
    echo 0x3d00350 1 > $DCC_PATH/config
    echo 0x3d00360 1 > $DCC_PATH/config
    echo 0x3d00370 1 > $DCC_PATH/config
    echo 0x3d00380 1 > $DCC_PATH/config
    echo 0x3d00390 1 > $DCC_PATH/config
    echo 0x3d003a0 1 > $DCC_PATH/config
    echo 0x3d003b0 1 > $DCC_PATH/config
    echo 0x3d003c0 1 > $DCC_PATH/config
    echo 0x3d003d0 1 > $DCC_PATH/config
    echo 0x3d003e0 1 > $DCC_PATH/config
    echo 0x3d00400 1 > $DCC_PATH/config
    echo 0x3d00410 8 > $DCC_PATH/config
    echo 0x3d0043c 15 > $DCC_PATH/config
    echo 0x3d00800 14 > $DCC_PATH/config
    echo 0x3d00840 4 > $DCC_PATH/config
    echo 0x3d00854 1 > $DCC_PATH/config
    echo 0x3d00860 37 > $DCC_PATH/config
    echo 0x3d01444 1 > $DCC_PATH/config
    echo 0x3d0201c 1 > $DCC_PATH/config
    echo 0x3d3c000 2 > $DCC_PATH/config
    echo 0x3d8ec30 3 > $DCC_PATH/config
}

config_dcc_lpm_pcu()
{
    # PCU -DCC for LPM path
    # Read only registers
    # cpu0
    echo 0x17800010 1 > $DCC_PATH/config
    echo 0x17800024 1 > $DCC_PATH/config
    echo 0x17800038 6 > $DCC_PATH/config
    echo 0x17800058 4 > $DCC_PATH/config
    echo 0x1780006c 1 > $DCC_PATH/config
    echo 0x178000f0 2 > $DCC_PATH/config
    #cpu1
    echo 0x17810010 1 > $DCC_PATH/config
    echo 0x17810024 1 > $DCC_PATH/config
    echo 0x17810038 6 > $DCC_PATH/config
    echo 0x17810058 4 > $DCC_PATH/config
    echo 0x1781006c 1 > $DCC_PATH/config
    echo 0x178100f0 2 > $DCC_PATH/config
    #cpu2
    echo 0x17820010 1 > $DCC_PATH/config
    echo 0x17820024 1 > $DCC_PATH/config
    echo 0x17820038 6 > $DCC_PATH/config
    echo 0x17820058 4 > $DCC_PATH/config
    echo 0x178200f0 2 > $DCC_PATH/config
    #cpu3
    echo 0x17830010 1 > $DCC_PATH/config
    echo 0x17830024 1 > $DCC_PATH/config
    echo 0x17830038 6 > $DCC_PATH/config
    echo 0x17830058 4 > $DCC_PATH/config
    echo 0x178300f0 2 > $DCC_PATH/config
    #cpu4
    echo 0x17840010 1 > $DCC_PATH/config
    echo 0x17840024 1 > $DCC_PATH/config
    echo 0x17840038 6 > $DCC_PATH/config
    echo 0x17840058 4 > $DCC_PATH/config
    echo 0x178400f0 2 > $DCC_PATH/config
    #cpu5
    echo 0x17850010 1 > $DCC_PATH/config
    echo 0x17850024 1 > $DCC_PATH/config
    echo 0x17850038 6 > $DCC_PATH/config
    echo 0x17850058 4 > $DCC_PATH/config
    echo 0x178500f0 2 > $DCC_PATH/config
    #cpu6
    echo 0x17860010 1 > $DCC_PATH/config
    echo 0x17860024 1 > $DCC_PATH/config
    echo 0x17860038 6 > $DCC_PATH/config
    echo 0x17860058 4 > $DCC_PATH/config
    echo 0x178600f0 2 > $DCC_PATH/config
    #cpu7
    echo 0x17870010 1 > $DCC_PATH/config
    echo 0x17870024 1 > $DCC_PATH/config
    echo 0x17870038 6 > $DCC_PATH/config
    echo 0x17870058 4 > $DCC_PATH/config
    echo 0x178700f0 2 > $DCC_PATH/config
    #L3
    echo 0x17880010 1 > $DCC_PATH/config
    echo 0x17880024 1 > $DCC_PATH/config
    echo 0x17880038 6 > $DCC_PATH/config
    echo 0x17880058 4 > $DCC_PATH/config
    echo 0x178800f0 2 > $DCC_PATH/config
    #silver/gold
    echo 0x1788006c 5 > $DCC_PATH/config
    echo 0x17880084 1 > $DCC_PATH/config
    echo 0x178800f4 5 > $DCC_PATH/config
    echo 0x17880118 9 > $DCC_PATH/config
    echo 0x178801c8 1 > $DCC_PATH/config
    #other pwr registers
    echo 0x1782006c 1 > $DCC_PATH/config
    echo 0x1783006c 1 > $DCC_PATH/config
    echo 0x1784006c 1 > $DCC_PATH/config
    echo 0x1785006c 1 > $DCC_PATH/config
    echo 0x1786006c 1 > $DCC_PATH/config
    echo 0x1787006c 1 > $DCC_PATH/config
    echo 0x17880080 1 > $DCC_PATH/config
    echo 0x17880090 5 > $DCC_PATH/config
    echo 0x178800e0 4 > $DCC_PATH/config
    echo 0x17880108 4 > $DCC_PATH/config
    echo 0x17880140 2 > $DCC_PATH/config
    echo 0x1788019c 2 > $DCC_PATH/config
    echo 0x178801b0 6 > $DCC_PATH/config
    echo 0x178801f0 5 > $DCC_PATH/config
    echo 0x17880258 1 > $DCC_PATH/config
}

config_dcc_gic()
{
    echo 0x17200104 29 > $DCC_PATH/config
    echo 0x17200204 29 > $DCC_PATH/config
    echo 0x17200384 29 > $DCC_PATH/config
    echo 0x17880250 2 > $DCC_PATH/config
    echo 0x1788025c 1 > $DCC_PATH/config
}

config_adsp()
{
    echo 0x3000304 1 > $DCC_PATH/config
    echo 0x3002028 1 > $DCC_PATH/config
    echo 0x30b0208 3 > $DCC_PATH/config
    echo 0x30b0228 3 > $DCC_PATH/config
    echo 0x30b0248 3 > $DCC_PATH/config
    echo 0x30b0268 3 > $DCC_PATH/config
    echo 0x30b0288 3 > $DCC_PATH/config
    echo 0x30b02a8 3 > $DCC_PATH/config
    echo 0x30b0400 3 > $DCC_PATH/config
    echo 0x3480400 3 > $DCC_PATH/config
}

config_dcc_apss_rscc()
{
    #APSS_RSCC_RSC register
    echo 0x17a00010 1 > $DCC_PATH/config
    echo 0x17a10010 1 > $DCC_PATH/config
    echo 0x17a20010 1 > $DCC_PATH/config
    echo 0x17a30010 1 > $DCC_PATH/config
    echo 0x17a00030 1 > $DCC_PATH/config
    echo 0x17a10030 1 > $DCC_PATH/config
    echo 0x17a20030 1 > $DCC_PATH/config
    echo 0x17a20d00 3 > $DCC_PATH/config
    echo 0x17a20d10 3 > $DCC_PATH/config
    echo 0x17a20d30 9 > $DCC_PATH/config
    echo 0x17a30030 1 > $DCC_PATH/config
    echo 0x17a00038 1 > $DCC_PATH/config
    echo 0x17a10038 1 > $DCC_PATH/config
    echo 0x17a20038 1 > $DCC_PATH/config
    echo 0x17a30038 1 > $DCC_PATH/config
    echo 0x17a00040 1 > $DCC_PATH/config
    echo 0x17a10040 1 > $DCC_PATH/config
    echo 0x17a20040 1 > $DCC_PATH/config
    echo 0x17a30040 1 > $DCC_PATH/config
    echo 0x17a00048 1 > $DCC_PATH/config
    echo 0x17a00400 3 > $DCC_PATH/config
    echo 0x17a10400 3 > $DCC_PATH/config
    echo 0x17a20400 3 > $DCC_PATH/config
    echo 0x17a30400 3 > $DCC_PATH/config
}

config_dcc_apss_pdc()
{
    echo 0xB200010 1 > $DCC_PATH/config
    echo 0xB200110 1 > $DCC_PATH/config
    echo 0xB200900 1 > $DCC_PATH/config
    echo 0xB201020 1 > $DCC_PATH/config
    echo 0xB201030 1 > $DCC_PATH/config
    echo 0xB20103C 1 > $DCC_PATH/config
    echo 0xB201200 3 > $DCC_PATH/config
    echo 0xB204510 2 > $DCC_PATH/config
    echo 0xB204520 1 > $DCC_PATH/config
}

config_dcc_prng()
{
    echo 0x10C1000 1 > $DCC_PATH/config
    echo 0x10C1004 1 > $DCC_PATH/config
    echo 0x10C1010 1 > $DCC_PATH/config
    echo 0x10C1014 1 > $DCC_PATH/config
    echo 0x10C1018 1 > $DCC_PATH/config
    echo 0x10C101C 1 > $DCC_PATH/config
    echo 0x10C1020 1 > $DCC_PATH/config
    echo 0x10C1024 1 > $DCC_PATH/config
    echo 0x10C1028 1 > $DCC_PATH/config
    echo 0x10C1100 1 > $DCC_PATH/config
    echo 0x10C1104 1 > $DCC_PATH/config
    echo 0x10C1108 1 > $DCC_PATH/config
    echo 0x10C1110 1 > $DCC_PATH/config
    echo 0x10C1114 1 > $DCC_PATH/config
    echo 0x10C1118 1 > $DCC_PATH/config
    echo 0x10C111C 1 > $DCC_PATH/config
    echo 0x10C1120 1 > $DCC_PATH/config
    echo 0x10C1124 1 > $DCC_PATH/config
    echo 0x10C1128 1 > $DCC_PATH/config
    echo 0x10C1130 1 > $DCC_PATH/config
    echo 0x10C1134 1 > $DCC_PATH/config
    echo 0x10C113C 1 > $DCC_PATH/config
    echo 0x10C1140 1 > $DCC_PATH/config
    echo 0x10C1148 1 > $DCC_PATH/config
    echo 0x10C114C 1 > $DCC_PATH/config
    echo 0x10C1150 1 > $DCC_PATH/config

    echo 0x10C0000 1 > $DCC_PATH/config
    echo 0x10C0004 1 > $DCC_PATH/config
    echo 0x10C0008 1 > $DCC_PATH/config
    echo 0x10C000C 1 > $DCC_PATH/config

    echo 0x10C2000 1 > $DCC_PATH/config
    echo 0x10C2004 1 > $DCC_PATH/config
}

config_dcc_ddr()
{
    #DDR -DCC starts here.
    #Start Link list #6
    #DDRSS
    echo 0x19080024 1 > $DCC_PATH/config
    echo 0x1908002c 1 > $DCC_PATH/config
    echo 0x19080034 1 > $DCC_PATH/config
    echo 0x1908003c 1 > $DCC_PATH/config
    echo 0x19080044 1 > $DCC_PATH/config
    echo 0x1908004c 1 > $DCC_PATH/config
    echo 0x19080058 2 > $DCC_PATH/config
    echo 0x190800c8 1 > $DCC_PATH/config
    echo 0x19080144 1 > $DCC_PATH/config
    echo 0x1908014c 1 > $DCC_PATH/config
    echo 0x19080174 1 > $DCC_PATH/config
    echo 0x1908017c 1 > $DCC_PATH/config
    echo 0x19080184 1 > $DCC_PATH/config
    echo 0x1908018c 1 > $DCC_PATH/config
    echo 0x19080194 1 > $DCC_PATH/config
    echo 0x1908019c 1 > $DCC_PATH/config
    echo 0x190801a4 1 > $DCC_PATH/config
    echo 0x190801ac 3 > $DCC_PATH/config

    #DDR LAGS
    echo 0x19091000 1 > $DCC_PATH/config
    echo 0x19092000 1 > $DCC_PATH/config
    echo 0x19093000 1 > $DCC_PATH/config
    echo 0x19093104 1 > $DCC_PATH/config
    echo 0x19094000 1 > $DCC_PATH/config
    echo 0x19094104 1 > $DCC_PATH/config
    echo 0x19095220 1 > $DCC_PATH/config

    #DPCC
    echo 0x190a80e4 2 > $DCC_PATH/config
    echo 0x190a80f8 1 > $DCC_PATH/config
    echo 0x190a80f8 5 > $DCC_PATH/config
    echo 0x190a8150 2 > $DCC_PATH/config
    echo 0x190a8164 2 > $DCC_PATH/config
    echo 0x190a8174 4 > $DCC_PATH/config
    echo 0x190a819c 1 > $DCC_PATH/config
    echo 0x190a81cc 1 > $DCC_PATH/config
    echo 0x190A8804 1 > $DCC_PATH/config
    echo 0x190A880C 1 > $DCC_PATH/config
    echo 0x190A8834 1 > $DCC_PATH/config
    echo 0x190A8840 2 > $DCC_PATH/config
    echo 0x190A8854 1 > $DCC_PATH/config
    echo 0x190A8860 3 > $DCC_PATH/config
    echo 0x190A8878 1 > $DCC_PATH/config
    echo 0x190A888C 1 > $DCC_PATH/config
    echo 0x190A9140 10 > $DCC_PATH/config
    echo 0x190A9188 2 > $DCC_PATH/config
    echo 0x190A9198 2 > $DCC_PATH/config
    echo 0x190A91AC 1 > $DCC_PATH/config
    echo 0x190A91B4 1 > $DCC_PATH/config
    echo 0x190A91C4 2 > $DCC_PATH/config
    echo 0x190A91D0 1 > $DCC_PATH/config
    echo 0x190A91E4 1 > $DCC_PATH/config
    echo 0x190AA034 4 > $DCC_PATH/config
    echo 0x190AA04C 1 > $DCC_PATH/config
    echo 0x190AA058 1 > $DCC_PATH/config
    echo 0x190AA064 1 > $DCC_PATH/config
    echo 0x190AA070 1 > $DCC_PATH/config


    #DPCC_PLL
    echo 0x190a0008 2 > $DCC_PATH/config
    echo 0x190a1008 2 > $DCC_PATH/config

    # MC0_CAB0
    echo 0x19243400 7 > $DCC_PATH/config
    echo 0x19243420 2 > $DCC_PATH/config
    echo 0x19243430 5 > $DCC_PATH/config
    echo 0x19243460 5 > $DCC_PATH/config
    echo 0x1924390C 1 > $DCC_PATH/config
    echo 0x19243920 1 > $DCC_PATH/config
    echo 0x19250400 2 > $DCC_PATH/config
    echo 0x19250410 3 > $DCC_PATH/config
    echo 0x19250420 2 > $DCC_PATH/config
    echo 0x19250430 1 > $DCC_PATH/config
    echo 0x19250440 1 > $DCC_PATH/config
    echo 0x19250448 1 > $DCC_PATH/config
    echo 0x192504A0 1 > $DCC_PATH/config
    echo 0x192504B0 4 > $DCC_PATH/config
    echo 0x192504D0 2 > $DCC_PATH/config
    echo 0x192504E0 1 > $DCC_PATH/config
    echo 0x19252400 2 > $DCC_PATH/config
    echo 0x19252410 1 > $DCC_PATH/config
    echo 0x19252418 1 > $DCC_PATH/config
    echo 0x19252450 9 > $DCC_PATH/config
    echo 0x19253400 9 > $DCC_PATH/config
    echo 0x19255110 1 > $DCC_PATH/config
    echo 0x19255130 1 > $DCC_PATH/config
    echo 0x19255150 1 > $DCC_PATH/config
    echo 0x19255170 1 > $DCC_PATH/config
    echo 0x19255190 1 > $DCC_PATH/config
    echo 0x19255210 1 > $DCC_PATH/config
    echo 0x19255230 1 > $DCC_PATH/config
    echo 0x192553B0 2 > $DCC_PATH/config
    echo 0x19255840 1 > $DCC_PATH/config
    echo 0x19255920 4 > $DCC_PATH/config
    echo 0x19255B00 8 > $DCC_PATH/config
    echo 0x19255B28 9 > $DCC_PATH/config
    echo 0x19256400 1 > $DCC_PATH/config
    echo 0x19256410 5 > $DCC_PATH/config
    echo 0x19259100 1 > $DCC_PATH/config
    echo 0x19259110 1 > $DCC_PATH/config
    echo 0x19259120 1 > $DCC_PATH/config

    #MC0 MC5
    echo 0x19260304 1 > $DCC_PATH/config
    echo 0x19260400 2 > $DCC_PATH/config
    echo 0x19260410 6 > $DCC_PATH/config
    echo 0x19260430 1 > $DCC_PATH/config
    echo 0x19260440 1 > $DCC_PATH/config
    echo 0x19260448 1 > $DCC_PATH/config
    echo 0x192604A0 1 > $DCC_PATH/config
    echo 0x192604B0 4 > $DCC_PATH/config
    echo 0x192604D0 2 > $DCC_PATH/config
    echo 0x192604E0 1 > $DCC_PATH/config
    echo 0x19262400 2 > $DCC_PATH/config
    echo 0x19262410 1 > $DCC_PATH/config
    echo 0x19262418 1 > $DCC_PATH/config
    echo 0x19262420 29 > $DCC_PATH/config
    echo 0x19263400 11 > $DCC_PATH/config
    echo 0x19265110 1 > $DCC_PATH/config
    echo 0x19265130 1 > $DCC_PATH/config
    echo 0x19265150 1 > $DCC_PATH/config
    echo 0x19265170 1 > $DCC_PATH/config
    echo 0x19265190 1 > $DCC_PATH/config
    echo 0x19265210 1 > $DCC_PATH/config
    echo 0x19265230 1 > $DCC_PATH/config
    echo 0x192653B0 2 > $DCC_PATH/config
    echo 0x19265C00 8 > $DCC_PATH/config
    echo 0x19265C28 8 > $DCC_PATH/config
    echo 0x19265C4C 6 > $DCC_PATH/config
    echo 0x19265C70 18 > $DCC_PATH/config
    echo 0x19266400 1 > $DCC_PATH/config
    echo 0x19266410 1 > $DCC_PATH/config
    echo 0x19266418 3 > $DCC_PATH/config
    echo 0x19269100 1 > $DCC_PATH/config
    echo 0x19269110 1 > $DCC_PATH/config
    echo 0x19269120 1 > $DCC_PATH/config

    #DDRPHY CH0
    echo 0x19281814 1 > $DCC_PATH/config
    echo 0x19283814 1 > $DCC_PATH/config
    echo 0x19285014 1 > $DCC_PATH/config
    echo 0x19286C04 1 > $DCC_PATH/config
    echo 0x19286D04 1 > $DCC_PATH/config
    echo 0x1928729C 1 > $DCC_PATH/config
    echo 0x192872A8 1 > $DCC_PATH/config
    echo 0x1928759C 1 > $DCC_PATH/config
    echo 0x192875A8 1 > $DCC_PATH/config

    #MCCC CH0
    echo 0x192E0610 4 > $DCC_PATH/config
    echo 0x192E0624 5 > $DCC_PATH/config
    echo 0x192E0640 1 > $DCC_PATH/config
    echo 0x192E0650 4 > $DCC_PATH/config
    echo 0x192E0670 1 > $DCC_PATH/config
    echo 0x192E0680 4 > $DCC_PATH/config

    #MC1 CAB0
    echo 0x19343400 7 > $DCC_PATH/config
    echo 0x19343420 2 > $DCC_PATH/config
    echo 0x19343430 5 > $DCC_PATH/config
    echo 0x19343460 5 > $DCC_PATH/config
    echo 0x1934390C 1 > $DCC_PATH/config
    echo 0x19343920 1 > $DCC_PATH/config
    echo 0x19350400 2 > $DCC_PATH/config
    echo 0x19350410 3 > $DCC_PATH/config
    echo 0x19350420 2 > $DCC_PATH/config
    echo 0x19350430 1 > $DCC_PATH/config
    echo 0x19350440 1 > $DCC_PATH/config
    echo 0x19350448 1 > $DCC_PATH/config
    echo 0x193504A0 1 > $DCC_PATH/config
    echo 0x193504B0 4 > $DCC_PATH/config
    echo 0x193504D0 2 > $DCC_PATH/config
    echo 0x193504E0 1 > $DCC_PATH/config
    echo 0x19352400 2 > $DCC_PATH/config
    echo 0x19352410 1 > $DCC_PATH/config
    echo 0x19352418 1 > $DCC_PATH/config
    echo 0x19352450 9 > $DCC_PATH/config
    echo 0x19353400 9 > $DCC_PATH/config
    echo 0x19355110 1 > $DCC_PATH/config
    echo 0x19355130 1 > $DCC_PATH/config
    echo 0x19355150 1 > $DCC_PATH/config
    echo 0x19355170 1 > $DCC_PATH/config
    echo 0x19355190 1 > $DCC_PATH/config
    echo 0x19355210 1 > $DCC_PATH/config
    echo 0x19355230 1 > $DCC_PATH/config
    echo 0x193553B0 2 > $DCC_PATH/config
    echo 0x19355840 1 > $DCC_PATH/config
    echo 0x19355920 4 > $DCC_PATH/config
    echo 0x19355B00 8 > $DCC_PATH/config
    echo 0x19355B28 9 > $DCC_PATH/config
    echo 0x19356400 1 > $DCC_PATH/config
    echo 0x19356410 5 > $DCC_PATH/config
    echo 0x19359100 1 > $DCC_PATH/config
    echo 0x19359110 1 > $DCC_PATH/config
    echo 0x19359120 1 > $DCC_PATH/config

    #MC1 MC5
    echo 0x19360304 1 > $DCC_PATH/config
    echo 0x19360400 2 > $DCC_PATH/config
    echo 0x19360410 6 > $DCC_PATH/config
    echo 0x19360430 1 > $DCC_PATH/config
    echo 0x19360440 1 > $DCC_PATH/config
    echo 0x19360448 1 > $DCC_PATH/config
    echo 0x193604A0 1 > $DCC_PATH/config
    echo 0x193604B0 4 > $DCC_PATH/config
    echo 0x193604D0 2 > $DCC_PATH/config
    echo 0x193604E0 1 > $DCC_PATH/config
    echo 0x19362400 2 > $DCC_PATH/config
    echo 0x19362410 1 > $DCC_PATH/config
    echo 0x19362418 1 > $DCC_PATH/config
    echo 0x19362420 29 > $DCC_PATH/config
    echo 0x19363400 11 > $DCC_PATH/config
    echo 0x19365110 1 > $DCC_PATH/config
    echo 0x19365130 1 > $DCC_PATH/config
    echo 0x19365150 1 > $DCC_PATH/config
    echo 0x19365170 1 > $DCC_PATH/config
    echo 0x19365190 1 > $DCC_PATH/config
    echo 0x19365210 1 > $DCC_PATH/config
    echo 0x19365230 1 > $DCC_PATH/config
    echo 0x193653B0 2 > $DCC_PATH/config
    echo 0x19365C00 8 > $DCC_PATH/config
    echo 0x19365C28 8 > $DCC_PATH/config
    echo 0x19365C4C 6 > $DCC_PATH/config
    echo 0x19365C70 18 > $DCC_PATH/config
    echo 0x19366400 1 > $DCC_PATH/config
    echo 0x19366410 1 > $DCC_PATH/config
    echo 0x19366418 3 > $DCC_PATH/config
    echo 0x19369100 1 > $DCC_PATH/config
    echo 0x19369110 1 > $DCC_PATH/config
    echo 0x19369120 1 > $DCC_PATH/config

    #DDRPHY CH1
    echo 0x19381814 1 > $DCC_PATH/config
    echo 0x19383814 1 > $DCC_PATH/config
    echo 0x19385014 1 > $DCC_PATH/config
    echo 0x19386C04 1 > $DCC_PATH/config
    echo 0x19386D04 1 > $DCC_PATH/config
    echo 0x1938729C 1 > $DCC_PATH/config
    echo 0x193872A8 1 > $DCC_PATH/config
    echo 0x1938759C 1 > $DCC_PATH/config
    echo 0x193875A8 1 > $DCC_PATH/config

    #MCC CH1
    echo 0x193E0610 4 > $DCC_PATH/config
    echo 0x193E0624 5 > $DCC_PATH/config
    echo 0x193E0640 1 > $DCC_PATH/config
    echo 0x193E0650 4 > $DCC_PATH/config
    echo 0x193E0670 1 > $DCC_PATH/config
    echo 0x193E0680 4 > $DCC_PATH/config


    #Pimem ramblur
    echo 0x610110 5 > $DCC_PATH/config

    #DDRPHY REGEN
    echo 0x19385758 1 > $DCC_PATH/config
    echo 0x19285530 1 > $DCC_PATH/config

    # SHRM2
    echo 0x1908E008 1 > $DCC_PATH/config
    echo 0x1908E01C 1 > $DCC_PATH/config
    echo 0x1908E030 1 > $DCC_PATH/config
    echo 0x1908E050 1 > $DCC_PATH/config
    echo 0x1908E070 1 > $DCC_PATH/config
    echo 0x1908E948 1 > $DCC_PATH/config
    echo 0x1908F04C 1 > $DCC_PATH/config
    echo 0x19030040 0x1 > $DCC_PATH/config_write
    echo 0x1903005c 0x22C000 > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C001 > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C002 > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C003 > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C004 > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C005 > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C006 > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C007 > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C008 > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C009 > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C00A > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C00B > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C00C > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C00D > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C00E > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C00F > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C010 > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C011 > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C012 > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C013 > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C014 > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C015 > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C016 > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C017 > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C018 > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C019 > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C01A > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C01B > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C01C > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C01D > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C01E > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C01F > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C300 > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C341 > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    echo 0x1903005c 0x22C7B1 > $DCC_PATH/config_write
    echo 0x19030010 1 > $DCC_PATH/config
    #End Link list #6
}

config_dcc_lpass()
{
    echo 0x3411000 2 > $DCC_PATH/config
    echo 0x3415004 2 > $DCC_PATH/config
    echo 0x3419054 2 > $DCC_PATH/config
    echo 0x3421000 5 > $DCC_PATH/config
    echo 0x3421020 > $DCC_PATH/config
    echo 0x3480208 3 > $DCC_PATH/config
    echo 0x3480228 3 > $DCC_PATH/config
    echo 0x3480248 3 > $DCC_PATH/config
    echo 0x3480268 3 > $DCC_PATH/config
    echo 0x3480288 3 > $DCC_PATH/config
    echo 0x34802A8 3 > $DCC_PATH/config
}

dc_noc_dump()
{
    #; dc_noc_errlog
    echo 0x190E0008 1 > $DCC_PATH/config
    echo 0x190E0010 1 > $DCC_PATH/config
    echo 0x190E0018 1 > $DCC_PATH/config
    echo 0x190E0020 8 > $DCC_PATH/config
    echo 0x190E0240 1 > $DCC_PATH/config
    echo 0x190E0248 1 > $DCC_PATH/config

    #;dc_noc_debugchain
    echo 0x190E5008 1 > $DCC_PATH/config
    echo 0x190E5018 1 > $DCC_PATH/config
    echo 0x6 > $DCC_PATH/loop
    echo 0x190E5010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
}

lpass_ag_noc_dump()
{
    #; lpass_ag_noc_lpass_ag_noc_Errorlogger_erl
    echo 0x3C40008 1 > $DCC_PATH/config
    echo 0x3C40010 1 > $DCC_PATH/config
    echo 0x3C40018 1 > $DCC_PATH/config
    echo 0x3C40020 8 > $DCC_PATH/config
    echo 0x3C4B040 1 > $DCC_PATH/config
    echo 0x3C4B048 1 > $DCC_PATH/config

    #; lpass QOSGEN registers
    echo 0x3C44010 1 > $DCC_PATH/config
    #0x3C45010 1 read 0
    echo 0x3C46010 1 > $DCC_PATH/config
    #0x3C54010 1 read 0

    #; lpass agnoc debugchain registers
    echo 0x3C41008 1 > $DCC_PATH/config
    echo 0x3C41018 1 > $DCC_PATH/config
    echo 0x5 > $DCC_PATH/loop
    echo 0x3C41010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop

    #;LPASS_AG_NOC_LPASS_AG_NOC_SIDEBANDMANAGERCONTROL_SBM_SENSEIN
    echo 0x3C4A100 1 > $DCC_PATH/config
}

mmss_noc_dump()
{
    #; mmss_noc_erl
    echo 0x1740008 1 > $DCC_PATH/config
    echo 0x1740010 1 > $DCC_PATH/config
    echo 0x1740018 1 > $DCC_PATH/config
    echo 0x1740020 1 > $DCC_PATH/config
    echo 0x1740024 1 > $DCC_PATH/config
    echo 0x1740028 1 > $DCC_PATH/config
    echo 0x174002C 1 > $DCC_PATH/config
    echo 0x1740030 1 > $DCC_PATH/config
    echo 0x1740240 1 > $DCC_PATH/config
    echo 0x1740248 1 > $DCC_PATH/config
    #;mmss noc debughchain registers
    echo 0x1741008 1 > $DCC_PATH/config
    echo 0x1741018 1 > $DCC_PATH/config
    echo 0x6 > $DCC_PATH/loop
    echo 0x1741010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
    #; mmss noc QOSGen registers
    echo 0x1753010 1 > $DCC_PATH/config
    echo 0x1754010 1 > $DCC_PATH/config
    echo 0x1755010 1 > $DCC_PATH/config
    echo 0x1756010 1 > $DCC_PATH/config
    echo 0x1757010 1 > $DCC_PATH/config
    echo 0x1758010 1 > $DCC_PATH/config
    echo 0x1759010 1 > $DCC_PATH/config
    #;mmss noc sensein registers
    echo 0x1740300 2 > $DCC_PATH/config
}

system_noc_dump()
{
    #; system noc errl
    echo 0x1680008 1 > $DCC_PATH/config
    echo 0x1680010 1 > $DCC_PATH/config
    echo 0x1680018 1 > $DCC_PATH/config
    echo 0x1680020 8 > $DCC_PATH/config
    echo 0x1680240 1 > $DCC_PATH/config
    echo 0x1680248 1 > $DCC_PATH/config

    #; system NOC QOSGEN
    echo 0x1691010 1 > $DCC_PATH/config
    echo 0x1694010 1 > $DCC_PATH/config
    echo 0x1695010 1 > $DCC_PATH/config
    echo 0x1696010 1 > $DCC_PATH/config
    echo 0x1697010 1 > $DCC_PATH/config
    echo 0x1698010 1 > $DCC_PATH/config
    echo 0x1699010 1 > $DCC_PATH/config

    #; system noc debugchain registers
    echo 0x1681008 1 > $DCC_PATH/config
    echo 0x1681018 1 > $DCC_PATH/config
    echo 0x6 > $DCC_PATH/loop
    echo 0x1681010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop
}

aggre_noc_dump()
{
    #;aggre_noc_a1noc_ErrorLogger_erl
    echo 0x16E0000 3 > $DCC_PATH/config
    echo 0x16E0010 1 > $DCC_PATH/config
    echo 0x16E0018 1 > $DCC_PATH/config
    echo 0x16E0020 8 > $DCC_PATH/config
    echo 0x16E0240 1 > $DCC_PATH/config
    echo 0x16E0248 1 > $DCC_PATH/config

    #; aggre_noc_QOS_GEN
    echo 0x1711010 1 > $DCC_PATH/config
    echo 0x1713010 1 > $DCC_PATH/config
    echo 0x1716010 1 > $DCC_PATH/config
    echo 0x16F2010 1 > $DCC_PATH/config

    #; agree_noc_pcie_anoc
    echo 0x16C0008 1 > $DCC_PATH/config
    echo 0x16C0010 1 > $DCC_PATH/config
    echo 0x16C0018 1 > $DCC_PATH/config
    echo 0x16C0020 8 > $DCC_PATH/config
    echo 0x16C0240 1 > $DCC_PATH/config
    echo 0x16C0248 1 > $DCC_PATH/config
    echo 0x16C7010 1 > $DCC_PATH/config

    #; A2NOC errlog
    echo 0x1700008 1 > $DCC_PATH/config
    echo 0x1700010 1 > $DCC_PATH/config
    echo 0x1700018 1 > $DCC_PATH/config
    echo 0x1700020 5 > $DCC_PATH/config
    echo 0x1700240 1 > $DCC_PATH/config
    echo 0x1700248 1 > $DCC_PATH/config

    #; AggNOC QOS GEN
    echo 0x170E010 1 > $DCC_PATH/config
    echo 0x170F010 1 > $DCC_PATH/config
    echo 0x1710010 1 > $DCC_PATH/config
    echo 0x1711010 1 > $DCC_PATH/config
    echo 0x1712010 1 > $DCC_PATH/config
    echo 0x1713010 1 > $DCC_PATH/config
    echo 0x1714010 1 > $DCC_PATH/config
    echo 0x1716010 1 > $DCC_PATH/config
    #0x1715010 1 read 0

    #; aggre_noc_DebugChain_east_debug
    echo 0x16E1008 1 > $DCC_PATH/config
    echo 0x16E1018 1 > $DCC_PATH/config
    echo 0x3 > $DCC_PATH/loop
    echo 0x16E1010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop

    #; aggre_noc_DebugChain_pcie_debug
    echo 0x16C1008 1 > $DCC_PATH/config
    echo 0x16C1018 1 > $DCC_PATH/config
    echo 0x3 > $DCC_PATH/loop
    echo 0x16C1010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop

    #; aggre_noc_DebugChain_center_debug
    echo 0x1701008 1 > $DCC_PATH/config
    echo 0x1701018 1 > $DCC_PATH/config
    echo 0x6 > $DCC_PATH/loop
    echo 0x1701010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop

    #; aggre_noc_DebugChain_west_debug
    echo 0x16E1008 1 > $DCC_PATH/config
    echo 0x16E1018 1 > $DCC_PATH/config
    echo 0x2 > $DCC_PATH/loop
    echo 0x16E1010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop

}

config_noc_dump()
{
    #; cnoc2 errlog registers
    echo 0x1500008 1 > $DCC_PATH/config
    echo 0x1500010 1 > $DCC_PATH/config
    echo 0x1500018 1 > $DCC_PATH/config
    echo 0x1500020 8 > $DCC_PATH/config
    echo 0x1500240 5 > $DCC_PATH/config
    echo 0x1500258 1 > $DCC_PATH/config
    echo 0x1500440 1 > $DCC_PATH/config
    echo 0x1500448 1 > $DCC_PATH/config

    #; cnoc2_cnoc2_center_DebugChain
    echo 0x1502008 1 > $DCC_PATH/config
    echo 0x1502018 1 > $DCC_PATH/config
    echo 0x8 > $DCC_PATH/loop
    echo 0x1502010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop

    #;cnoc2_cnoc2_south_DebugChain
    echo 0x1502088 1 > $DCC_PATH/config
    echo 0x1502098 1 > $DCC_PATH/config
    echo 0x3 > $DCC_PATH/loop
    echo 0x1502090 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop

    #;cnoc2_cnoc2_west_DebugChain
    echo 0x1502288 1 > $DCC_PATH/config
    echo 0x1502298 1 > $DCC_PATH/config
    echo 0x2 > $DCC_PATH/loop
    echo 0x1502290 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop

    #; cnoc2_cnoc2_north_DebugChain
    echo 0x1502188 1 > $DCC_PATH/config
    echo 0x1502198 1 > $DCC_PATH/config
    echo 0x2 > $DCC_PATH/loop
    echo 0x1502190 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop

    #; cnoc2_cnoc2_lpass_DebugChain_debug
    echo 0x1502208 1 > $DCC_PATH/config
    echo 0x1502218 1 > $DCC_PATH/config
    echo 0x2 > $DCC_PATH/loop
    echo 0x1502210 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop

    #;cnoc2_cnoc2_east_DebugChain_debug
    echo 0x1502288 1 > $DCC_PATH/config
    echo 0x1502298 1 > $DCC_PATH/config
    echo 0x2 > $DCC_PATH/loop
    echo 0x1502290 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop

    #; cnoc3 errlog registers
    echo 0x1510008 1 > $DCC_PATH/config
    echo 0x1510010 1 > $DCC_PATH/config
    echo 0x1510018 1 > $DCC_PATH/config
    echo 0x1510020 8 > $DCC_PATH/config
    echo 0x1510240 1 > $DCC_PATH/config
    echo 0x1510248 1 > $DCC_PATH/config
    echo 0x1510440 1 > $DCC_PATH/config
    echo 0x1510448 1 > $DCC_PATH/config

    #; cnoc3_cnoc3_center_DebugChain_debug
    echo 0x1512008 1 > $DCC_PATH/config
    echo 0x1512018 1 > $DCC_PATH/config
    echo 0xb > $DCC_PATH/loop
    echo 0x1512010 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop

    #; cnoc3_cnoc3_south_DebugChain_debug
    echo 0x1512088 1 > $DCC_PATH/config
    echo 0x1512098 1 > $DCC_PATH/config
    echo 0x2 > $DCC_PATH/loop
    echo 0x1512090 2 > $DCC_PATH/config
    echo 0x1 > $DCC_PATH/loop

    #; CNOC2_CNOC2_INTERFACE_DISABLE_DEVICE_BUFF_SBM_SENSEIN
    echo 0x1506100 1 > $DCC_PATH/config
    #; CNOC3_CNOC3_INTERFACE_DISABLE_DEVICE_BUFF_SBM_SENSEIN
    echo 0x1515100 1 > $DCC_PATH/config
    #; CONFIG_NOC_CENTER_NIU_STATUS0_SBM_SENSEIN
    echo 0x1513100 1 > $DCC_PATH/config
}

config_dcc_rpmh()
{
    echo 0xb281024 1 > $DCC_PATH/config
    echo 0xbde1034 1 > $DCC_PATH/config

    #RPMH_PDC_APSS
    echo 0xb201020 2 > $DCC_PATH/config
    echo 0xb211020 2 > $DCC_PATH/config
    echo 0xb221020 2 > $DCC_PATH/config
    echo 0xb231020 2 > $DCC_PATH/config
    echo 0xb204520 1 > $DCC_PATH/config
    echo 0xBDE182C 1 > $DCC_PATH/config
    echo 0xBDF0234 1 > $DCC_PATH/config
    echo 0xBBF3904 1 > $DCC_PATH/config
    echo 0xBBF0004 1 > $DCC_PATH/config
    echo 0xBBF034C 1 > $DCC_PATH/config
    echo 0xBBF0800 1 > $DCC_PATH/config
}

config_dcc_epss()
{
    #EPSSFAST_SEQ_MEM_r register
    echo 0x17d80100 200 > $DCC_PATH/config
    echo 0x17D9001C 1 > $DCC_PATH/config
    echo 0x17D900DC 1 > $DCC_PATH/config
    echo 0x17D900E8 1 > $DCC_PATH/config
    echo 0x17D90320 1 > $DCC_PATH/config
    echo 0x17D9101C 1 > $DCC_PATH/config
    echo 0x17D910DC 1 > $DCC_PATH/config
    echo 0x17D910E8 1 > $DCC_PATH/config
    echo 0x17D91320 6 > $DCC_PATH/config
    echo 0x17D9201C 1 > $DCC_PATH/config
    echo 0x17D920DC 1 > $DCC_PATH/config
    echo 0x17D920E8 1 > $DCC_PATH/config
    echo 0x17D92320 1 > $DCC_PATH/config
    echo 0x17d80000 3 > $DCC_PATH/config
    echo 0x17d80010 2 > $DCC_PATH/config
    echo 0x17d90000 4 > $DCC_PATH/config
    echo 0x17d90014 2 > $DCC_PATH/config
    echo 0x17d90024 22 > $DCC_PATH/config
    echo 0x17d90080 5 > $DCC_PATH/config
    echo 0x17d900b0 1 > $DCC_PATH/config
    echo 0x17d900b8 2 > $DCC_PATH/config
    echo 0x17d900d0 3 > $DCC_PATH/config
    echo 0x17d900e0 2 > $DCC_PATH/config
    echo 0x17d900ec 2 > $DCC_PATH/config
    echo 0x17d90100 40 > $DCC_PATH/config
    echo 0x17d90200 40 > $DCC_PATH/config
    echo 0x17d90304 4 > $DCC_PATH/config
    echo 0x17d90350 30 > $DCC_PATH/config
    echo 0x17d903e0 2 > $DCC_PATH/config
    echo 0x17d90404 1 > $DCC_PATH/config
    echo 0x17d91000 4 > $DCC_PATH/config
    echo 0x17d91014 2 > $DCC_PATH/config
    echo 0x17d91024 22 > $DCC_PATH/config
    echo 0x17d91080 8 > $DCC_PATH/config
    echo 0x17d910b0 1 > $DCC_PATH/config
    echo 0x17d910b8 2 > $DCC_PATH/config
    echo 0x17d910d0 3 > $DCC_PATH/config
    echo 0x17d910e0 2 > $DCC_PATH/config
    echo 0x17d910ec 2 > $DCC_PATH/config
    echo 0x17d91100 40 > $DCC_PATH/config
    echo 0x17d91200 40 > $DCC_PATH/config
    echo 0x17d91304 4 > $DCC_PATH/config
    echo 0x17d91324 3 > $DCC_PATH/config
    echo 0x17d91350 34 > $DCC_PATH/config
    echo 0x17d913e0 5 > $DCC_PATH/config
    echo 0x17d91404 1 > $DCC_PATH/config
    echo 0x17d92000 4 > $DCC_PATH/config
    echo 0x17d92014 2 > $DCC_PATH/config
    echo 0x17d92024 22 > $DCC_PATH/config
    echo 0x17d92080 6 > $DCC_PATH/config
    echo 0x17d920b0 1 > $DCC_PATH/config
    echo 0x17d920b8 2 > $DCC_PATH/config
    echo 0x17d920d0 3 > $DCC_PATH/config
    echo 0x17d920e0 2 > $DCC_PATH/config
    echo 0x17d920ec 2 > $DCC_PATH/config
    echo 0x17d92100 40 > $DCC_PATH/config
    echo 0x17d92200 40 > $DCC_PATH/config
    echo 0x17d92304 4 > $DCC_PATH/config
    echo 0x17d92320 2 > $DCC_PATH/config
    echo 0x17d92350 31 > $DCC_PATH/config
    echo 0x17d923e0 3 > $DCC_PATH/config
    echo 0x17d92404 1 > $DCC_PATH/config
    echo 0x17d98000 8 > $DCC_PATH/config
    echo 0x17d98020 2 > $DCC_PATH/config
}

config_dcc_gict()
{
    #APSS_GIC600_GICD_APSS
    echo 0x17220000 1 > $DCC_PATH/config
    echo 0x17220008 1 > $DCC_PATH/config
    echo 0x17220010 1 > $DCC_PATH/config
    echo 0x17220018 1 > $DCC_PATH/config
    echo 0x17220020 1 > $DCC_PATH/config
    echo 0x17220028 1 > $DCC_PATH/config
    echo 0x17220040 1 > $DCC_PATH/config
    echo 0x17220048 1 > $DCC_PATH/config
    echo 0x17220050 1 > $DCC_PATH/config
    echo 0x17220060 1 > $DCC_PATH/config
    echo 0x17220068 1 > $DCC_PATH/config
    echo 0x17220080 1 > $DCC_PATH/config
    echo 0x17220088 1 > $DCC_PATH/config
    echo 0x17220090 1 > $DCC_PATH/config
    echo 0x172200A0 1 > $DCC_PATH/config
    echo 0x172200A8 1 > $DCC_PATH/config
    echo 0x172200C0 1 > $DCC_PATH/config
    echo 0x172200C8 1 > $DCC_PATH/config
    echo 0x172200D0 1 > $DCC_PATH/config
    echo 0x172200E0 1 > $DCC_PATH/config
    echo 0x172200E8 1 > $DCC_PATH/config
    echo 0x17220100 1 > $DCC_PATH/config
    echo 0x17220108 1 > $DCC_PATH/config
    echo 0x17220110 1 > $DCC_PATH/config
    echo 0x17220120 1 > $DCC_PATH/config
    echo 0x17220128 1 > $DCC_PATH/config
    echo 0x17220140 1 > $DCC_PATH/config
    echo 0x17220148 1 > $DCC_PATH/config
    echo 0x17220150 1 > $DCC_PATH/config
    echo 0x17220160 1 > $DCC_PATH/config
    echo 0x17220168 1 > $DCC_PATH/config
    echo 0x17220180 1 > $DCC_PATH/config
    echo 0x17220188 1 > $DCC_PATH/config
    echo 0x17220190 1 > $DCC_PATH/config
    echo 0x172201A0 1 > $DCC_PATH/config
    echo 0x172201A8 1 > $DCC_PATH/config
    echo 0x172201C0 1 > $DCC_PATH/config
    echo 0x172201C8 1 > $DCC_PATH/config
    echo 0x172201D0 1 > $DCC_PATH/config
    echo 0x172201E0 1 > $DCC_PATH/config
    echo 0x172201E8 1 > $DCC_PATH/config
    echo 0x17220200 1 > $DCC_PATH/config
    echo 0x17220208 1 > $DCC_PATH/config
    echo 0x17220210 1 > $DCC_PATH/config
    echo 0x17220220 1 > $DCC_PATH/config
    echo 0x17220228 1 > $DCC_PATH/config
    echo 0x17220240 1 > $DCC_PATH/config
    echo 0x17220248 1 > $DCC_PATH/config
    echo 0x17220250 1 > $DCC_PATH/config
    echo 0x17220260 1 > $DCC_PATH/config
    echo 0x17220268 1 > $DCC_PATH/config
    echo 0x17220280 1 > $DCC_PATH/config
    echo 0x17220288 1 > $DCC_PATH/config
    echo 0x17220290 1 > $DCC_PATH/config
    echo 0x172202A0 1 > $DCC_PATH/config
    echo 0x172202A8 1 > $DCC_PATH/config
    echo 0x172202C0 1 > $DCC_PATH/config
    echo 0x172202C8 1 > $DCC_PATH/config
    echo 0x172202D0 1 > $DCC_PATH/config
    echo 0x172202E0 1 > $DCC_PATH/config
    echo 0x172202E8 1 > $DCC_PATH/config
    echo 0x17220300 1 > $DCC_PATH/config
    echo 0x17220308 1 > $DCC_PATH/config
    echo 0x17220310 1 > $DCC_PATH/config
    echo 0x17220320 1 > $DCC_PATH/config
    echo 0x17220328 1 > $DCC_PATH/config
    echo 0x17220340 1 > $DCC_PATH/config
    echo 0x17220348 1 > $DCC_PATH/config
    echo 0x17220350 1 > $DCC_PATH/config
    echo 0x17220360 1 > $DCC_PATH/config
    echo 0x17220368 1 > $DCC_PATH/config
    echo 0x1722E000 1 > $DCC_PATH/config
    echo 0x1722E800 1 > $DCC_PATH/config
    echo 0x1722E808 1 > $DCC_PATH/config
    echo 0x1722FFBC 1 > $DCC_PATH/config
    echo 0x1722FFC8 1 > $DCC_PATH/config
    echo 0x1722FFD0 12 > $DCC_PATH/config
}

config_dcc_misc()
{
    #secure WDOG register
    echo 0xc230000 6 > $DCC_PATH/config
}

config_cb()
{
    echo 0xEC80010 1 > $DCC_PATH/config
    echo 0xEC81000 1 > $DCC_PATH/config
    echo 0xEC81010 16 > $DCC_PATH/config
    echo 0xEC81050 16 > $DCC_PATH/config
    echo 0xEC81090 16 > $DCC_PATH/config
    echo 0xEC810D0 16 > $DCC_PATH/config
    echo 0xEC81110 16 > $DCC_PATH/config
}

config_rdpm_llm_reg()
{
	# Silver LLM register
	echo 0x17B70220 2 > $DCC_PATH/config
	echo 0x17B702A0 2 > $DCC_PATH/config
	echo 0x17B784A0 12 > $DCC_PATH/config
	echo 0x17B78520 1 > $DCC_PATH/config
	echo 0x17B78588 1 > $DCC_PATH/config
	echo 0x17B78D90 12 > $DCC_PATH/config
	echo 0x17B79010 10 > $DCC_PATH/config
	echo 0x17B79090 10 > $DCC_PATH/config
	echo 0x17B79A90 8 > $DCC_PATH/config

	# RDPM register
	echo 0x634008 1 > $DCC_PATH/config
	echo 0x634F00 8 > $DCC_PATH/config
	echo 0x635560 1 > $DCC_PATH/config
	echo 0x635570 1 > $DCC_PATH/config
	echo 0x635580 1 > $DCC_PATH/config
	echo 0x635590 1 > $DCC_PATH/config
	echo 0x6355A0 4 > $DCC_PATH/config
	echo 0x635600 1 > $DCC_PATH/config
	echo 0x635610 1 > $DCC_PATH/config
}

config_modem()
{
    echo 0x4080304 1 > $DCC_PATH/config
    echo 0x4082028 1 > $DCC_PATH/config
    echo 0x4130208 3 > $DCC_PATH/config
    echo 0x4130228 3 > $DCC_PATH/config
    echo 0x4130248 3 > $DCC_PATH/config
    echo 0x4130268 3 > $DCC_PATH/config
    echo 0x4130288 3 > $DCC_PATH/config
    echo 0x41302a8 3 > $DCC_PATH/config
    echo 0x4130400 3 > $DCC_PATH/config
    echo 0x4200400 3 > $DCC_PATH/config
    echo 0x19142010 1 > $DCC_PATH/config
    echo 0x19102010 1 > $DCC_PATH/config
}

config_wpss()
{
    echo 0x8a00304 1 > $DCC_PATH/config
    echo 0x8a02028 1 > $DCC_PATH/config
    echo 0x8ab0208 3 > $DCC_PATH/config
    echo 0x8ab0228 3 > $DCC_PATH/config
    echo 0x8ab0248 3 > $DCC_PATH/config
    echo 0x8ab0268 3 > $DCC_PATH/config
    echo 0x8ab0288 3 > $DCC_PATH/config
    echo 0x8ab02a8 3 > $DCC_PATH/config
    echo 0x8ab0400 3 > $DCC_PATH/config
    echo 0x8b00400 3 > $DCC_PATH/config
    echo 0x8A8C124 1 > $DCC_PATH/config
    echo 0x8A8C01C 1 > $DCC_PATH/config
    echo 0x8B00038 1 > $DCC_PATH/config
    echo 0x8B00040 1 > $DCC_PATH/config
    echo 0x8A8C138 1 > $DCC_PATH/config
    echo 0x8B00208 3 > $DCC_PATH/config
    echo 0x8B00228 3 > $DCC_PATH/config
    echo 0x8B00248 3 > $DCC_PATH/config
    echo 0x8B00268 3 > $DCC_PATH/config
    echo 0x8A8C124 1 > $DCC_PATH/config
    echo 0x8A8C01C 1 > $DCC_PATH/config
    echo 0x8B00038 1 > $DCC_PATH/config
    echo 0x8B00040 1 > $DCC_PATH/config
    echo 0x8A8C138 1 > $DCC_PATH/config
    echo 0x8AA3020 2 > $DCC_PATH/config
    echo 0x8AA3000 2 > $DCC_PATH/config
    echo 0x8AA2000 2 > $DCC_PATH/config
    echo 0x8A90500 32 > $DCC_PATH/config
}

config_gcc()
{
    #; GCC Registers
    echo 0x12015C 2 > $DCC_PATH/config
    echo 0x120464 2 > $DCC_PATH/config
    echo 0x12C15C 2 > $DCC_PATH/config
    echo 0x12C464 2 > $DCC_PATH/config
    echo 0x188040 1 > $DCC_PATH/config
    echo 0x1A0884 1 > $DCC_PATH/config
    #CBCR register data
    echo 0x120018 4 > $DCC_PATH/config
    echo 0x12002c 3 > $DCC_PATH/config
    echo 0x12015C 2 > $DCC_PATH/config
    echo 0x120464 2 > $DCC_PATH/config
    echo 0x121004 1 > $DCC_PATH/config
    echo 0x12100c 2 > $DCC_PATH/config
    echo 0x124004 1 > $DCC_PATH/config
    echo 0x12400c 2 > $DCC_PATH/config
    echo 0x125004 1 > $DCC_PATH/config
    echo 0x125010 1 > $DCC_PATH/config
    echo 0x127004 3 > $DCC_PATH/config
    echo 0x127140 1 > $DCC_PATH/config
    echo 0x127274 1 > $DCC_PATH/config
    echo 0x1273a8 1 > $DCC_PATH/config
    echo 0x1274dc 1 > $DCC_PATH/config
    echo 0x128004 3 > $DCC_PATH/config
    echo 0x128140 1 > $DCC_PATH/config
    echo 0x128274 1 > $DCC_PATH/config
    echo 0x1283a8 1 > $DCC_PATH/config
    echo 0x1284dc 1 > $DCC_PATH/config
    echo 0x12C15C 2 > $DCC_PATH/config
    echo 0x12C464 2 > $DCC_PATH/config
    echo 0x12a004 1 > $DCC_PATH/config
    echo 0x12b004 1 > $DCC_PATH/config
    echo 0x12b00c 1 > $DCC_PATH/config
    echo 0x12c018 1 > $DCC_PATH/config
    echo 0x12c020 1 > $DCC_PATH/config
    echo 0x12c028 1 > $DCC_PATH/config
    echo 0x12c030 5 > $DCC_PATH/config
    echo 0x12c174 1 > $DCC_PATH/config
    echo 0x12c2a8 1 > $DCC_PATH/config
    echo 0x12c2c8 7 > $DCC_PATH/config
    echo 0x12d004 2 > $DCC_PATH/config
    echo 0x12f004 3 > $DCC_PATH/config
    echo 0x12f014 18 > $DCC_PATH/config
    echo 0x12f77c 7 > $DCC_PATH/config
    echo 0x130004 2 > $DCC_PATH/config
    echo 0x131000 2 > $DCC_PATH/config
    echo 0x132004 1 > $DCC_PATH/config
    echo 0x133000 1 > $DCC_PATH/config
    echo 0x13300c 1 > $DCC_PATH/config
    echo 0x133140 1 > $DCC_PATH/config
    echo 0x13314c 1 > $DCC_PATH/config
    echo 0x134004 1 > $DCC_PATH/config
    echo 0x135004 2 > $DCC_PATH/config
    echo 0x136004 7 > $DCC_PATH/config
    echo 0x137004 3 > $DCC_PATH/config
    echo 0x137014 1 > $DCC_PATH/config
    echo 0x142004 2 > $DCC_PATH/config
    echo 0x142014 2 > $DCC_PATH/config
    echo 0x143004 3 > $DCC_PATH/config
    echo 0x144004 6 > $DCC_PATH/config
    echo 0x146004 2 > $DCC_PATH/config
    echo 0x147004 2 > $DCC_PATH/config
    echo 0x148004 1 > $DCC_PATH/config
    echo 0x149018 1 > $DCC_PATH/config
    echo 0x149020 2 > $DCC_PATH/config
    echo 0x14905c 3 > $DCC_PATH/config
    echo 0x149084 3 > $DCC_PATH/config
    echo 0x14a004 2 > $DCC_PATH/config
    echo 0x14b004 3 > $DCC_PATH/config
    echo 0x14b028 2 > $DCC_PATH/config
    echo 0x14c004 3 > $DCC_PATH/config
    echo 0x14d000 1 > $DCC_PATH/config
    echo 0x150004 7 > $DCC_PATH/config
    echo 0x151004 1 > $DCC_PATH/config
    echo 0x15100c 2 > $DCC_PATH/config
    echo 0x153000 6 > $DCC_PATH/config
    echo 0x154004 8 > $DCC_PATH/config
    echo 0x156004 4 > $DCC_PATH/config
    echo 0x15602c 2 > $DCC_PATH/config
    echo 0x157000 6 > $DCC_PATH/config
    echo 0x15701c 2 > $DCC_PATH/config
    echo 0x158000 4 > $DCC_PATH/config
    echo 0x158174 3 > $DCC_PATH/config
    echo 0x159004 1 > $DCC_PATH/config
    echo 0x15e004 2 > $DCC_PATH/config
    echo 0x172008 2 > $DCC_PATH/config
    echo 0x172018 1 > $DCC_PATH/config
    echo 0x174000 1 > $DCC_PATH/config
    echo 0x175000 1 > $DCC_PATH/config
    echo 0x176000 1 > $DCC_PATH/config
    echo 0x17a004 1 > $DCC_PATH/config
    echo 0x17b018 3 > $DCC_PATH/config
    echo 0x17b028 1 > $DCC_PATH/config
    echo 0x17b030 2 > $DCC_PATH/config
    echo 0x17b03c 1 > $DCC_PATH/config
    echo 0x17b044 1 > $DCC_PATH/config
    echo 0x17b08c 3 > $DCC_PATH/config
    echo 0x181004 6 > $DCC_PATH/config
    echo 0x181154 1 > $DCC_PATH/config
    echo 0x184004 24 > $DCC_PATH/config
    echo 0x184794 1 > $DCC_PATH/config
    echo 0x18479c 1 > $DCC_PATH/config
    echo 0x1847a4 1 > $DCC_PATH/config
    echo 0x1847ac 2 > $DCC_PATH/config
    echo 0x1847b8 10 > $DCC_PATH/config
    echo 0x186004 6 > $DCC_PATH/config
    echo 0x187018 1 > $DCC_PATH/config
    echo 0x187020 3 > $DCC_PATH/config
    echo 0x187064 1 > $DCC_PATH/config
    echo 0x18706c 1 > $DCC_PATH/config
    echo 0x1870a4 1 > $DCC_PATH/config
    echo 0x1870c0 1 > $DCC_PATH/config
    echo 0x1870d4 1 > $DCC_PATH/config
    echo 0x188040 1 > $DCC_PATH/config
    echo 0x18a004 6 > $DCC_PATH/config
    echo 0x18a04c 5 > $DCC_PATH/config
    echo 0x192004 15 > $DCC_PATH/config
    echo 0x1923f0 1 > $DCC_PATH/config
    echo 0x1923f8 3 > $DCC_PATH/config
    echo 0x193004 2 > $DCC_PATH/config
    echo 0x193140 1 > $DCC_PATH/config
    echo 0x194004 1 > $DCC_PATH/config
    echo 0x198004 1 > $DCC_PATH/config
    echo 0x199018 1 > $DCC_PATH/config
    echo 0x199020 1 > $DCC_PATH/config
    echo 0x199028 2 > $DCC_PATH/config
    echo 0x199164 3 > $DCC_PATH/config
    echo 0x19a000 9 > $DCC_PATH/config
    echo 0x19a28c 3 > $DCC_PATH/config
    echo 0x19b004 3 > $DCC_PATH/config
    echo 0x1A0884 1 > $DCC_PATH/config
    echo 0x1A915C 2 > $DCC_PATH/config
    echo 0x1A9464 2 > $DCC_PATH/config
    echo 0x1a0004 1 > $DCC_PATH/config
    echo 0x1a000c 1 > $DCC_PATH/config
    echo 0x1a0014 1 > $DCC_PATH/config
    echo 0x1a8004 1 > $DCC_PATH/config
    echo 0x1b0134 2 > $DCC_PATH/config
    echo 0x1b0154 9 > $DCC_PATH/config
    echo 0x1b017c 1 > $DCC_PATH/config
    echo 0x1b2004 7 > $DCC_PATH/config
    echo 0x1b3004 2 > $DCC_PATH/config
    echo 0x1b3028 1 > $DCC_PATH/config
    echo 0x1b3048 1 > $DCC_PATH/config
    #GCC PLL registers
    echo 0x100000 2 > $DCC_PATH/config
    echo 0x101000 2 > $DCC_PATH/config
    echo 0x102000 2 > $DCC_PATH/config
    echo 0x103000 2 > $DCC_PATH/config
    echo 0x104000 2 > $DCC_PATH/config
    echo 0x105000 2 > $DCC_PATH/config
    echo 0x106000 2 > $DCC_PATH/config
    echo 0x107000 2 > $DCC_PATH/config
    echo 0x108000 2 > $DCC_PATH/config
    echo 0x109000 2 > $DCC_PATH/config
    echo 0x10a000 2 > $DCC_PATH/config
    echo 0x116100 1 > $DCC_PATH/config
    echo 0x120004 2 > $DCC_PATH/config
    echo 0x127028 1 > $DCC_PATH/config
    echo 0x12715c 1 > $DCC_PATH/config
    echo 0x127290 1 > $DCC_PATH/config
    echo 0x1273c4 1 > $DCC_PATH/config
    echo 0x1274f8 1 > $DCC_PATH/config
    echo 0x128028 1 > $DCC_PATH/config
    echo 0x12815c 1 > $DCC_PATH/config
    echo 0x128290 1 > $DCC_PATH/config
    echo 0x1283c4 1 > $DCC_PATH/config
    echo 0x1284f8 1 > $DCC_PATH/config
    echo 0x12c004 2 > $DCC_PATH/config
    echo 0x12c058 1 > $DCC_PATH/config
    echo 0x133028 1 > $DCC_PATH/config
    echo 0x146020 1 > $DCC_PATH/config
    echo 0x149004 2 > $DCC_PATH/config
    echo 0x151028 1 > $DCC_PATH/config
    echo 0x154164 1 > $DCC_PATH/config
    echo 0x16301c 1 > $DCC_PATH/config
    echo 0x163024 1 > $DCC_PATH/config
    echo 0x16302c 1 > $DCC_PATH/config
    echo 0x163034 1 > $DCC_PATH/config
    echo 0x165000 1 > $DCC_PATH/config
    echo 0x165008 1 > $DCC_PATH/config
    echo 0x165010 1 > $DCC_PATH/config
    echo 0x165018 1 > $DCC_PATH/config
    echo 0x166000 1 > $DCC_PATH/config
    echo 0x166008 1 > $DCC_PATH/config
    echo 0x166010 1 > $DCC_PATH/config
    echo 0x166018 1 > $DCC_PATH/config
    echo 0x167000 1 > $DCC_PATH/config
    echo 0x167008 1 > $DCC_PATH/config
    echo 0x167010 1 > $DCC_PATH/config
    echo 0x167018 1 > $DCC_PATH/config
    echo 0x16a000 1 > $DCC_PATH/config
    echo 0x16a008 1 > $DCC_PATH/config
    echo 0x16a010 1 > $DCC_PATH/config
    echo 0x16a018 1 > $DCC_PATH/config
    echo 0x17901c 1 > $DCC_PATH/config
    echo 0x179024 1 > $DCC_PATH/config
    echo 0x17902c 1 > $DCC_PATH/config
    echo 0x179034 1 > $DCC_PATH/config
    echo 0x17b004 2 > $DCC_PATH/config
    echo 0x184078 1 > $DCC_PATH/config
    echo 0x186038 1 > $DCC_PATH/config
    echo 0x187004 2 > $DCC_PATH/config
    echo 0x193024 1 > $DCC_PATH/config
    echo 0x199004 2 > $DCC_PATH/config
    echo 0x199044 1 > $DCC_PATH/config
    echo 0x1b101c 1 > $DCC_PATH/config
    echo 0x1b1024 1 > $DCC_PATH/config
    echo 0x1b102c 1 > $DCC_PATH/config
    echo 0x1b1034 1 > $DCC_PATH/config
    echo 0xc2a0000 2 > $DCC_PATH/config
    echo 0xc2a1000 2 > $DCC_PATH/config
    echo 0xc2a900c 1 > $DCC_PATH/config
    echo 0xc2a901c 1 > $DCC_PATH/config
    echo 0xc2a9024 1 > $DCC_PATH/config
}

config_qtimer_regs()
{
    #;GICR_CTLR & GICR_WAKER
    echo 0x17260000 1 > $DCC_PATH/config
    echo 0x17260014 1 > $DCC_PATH/config
    echo 0x17280000 1 > $DCC_PATH/config
    echo 0x17280014 1 > $DCC_PATH/config
    echo 0x172A0000 1 > $DCC_PATH/config
    echo 0x172A0014 1 > $DCC_PATH/config
    echo 0x172C0000 1 > $DCC_PATH/config
    echo 0x172C0014 1 > $DCC_PATH/config
    echo 0x172E0000 1 > $DCC_PATH/config
    echo 0x172E0014 1 > $DCC_PATH/config
    #;qtimer regs
    echo 0x17421000 16 > $DCC_PATH/config
    #;gicd router
    echo 0x17206138 1 > $DCC_PATH/config
    echo 0x17206140 1 > $DCC_PATH/config
    echo 0x17206148 1 > $DCC_PATH/config
}

config_aoss_regs()
{
    #; AOSS_CC_RESET_DEBUG_ENABLE
    echo 0xC2F0000 1 > $DCC_PATH/config
    #; AOSS_CC_RESET_STATUS
    echo 0xC2F1000 1 > $DCC_PATH/config
    #; AOSS_CC_RESET_FSM_STATUS
    echo 0xC2F1004 1 > $DCC_PATH/config
    echo 0xC2A8014 1 > $DCC_PATH/config
    echo 0xC2A8030 1 > $DCC_PATH/config
    echo 0xC2A8028 1 > $DCC_PATH/config
    echo 0xC2A8130 1 > $DCC_PATH/config
    echo 0x190A8188 1 > $DCC_PATH/config
    echo 0x190A818C 1 > $DCC_PATH/config
    echo 0x190A8198 1 > $DCC_PATH/config
    echo 0x190A8194 1 > $DCC_PATH/config
    echo 0xC2F3000 1 > $DCC_PATH/config
    echo 0xC2A8038 1 > $DCC_PATH/config
    echo 0xC2A80DC 1 > $DCC_PATH/config
    echo 0xC2A80E0 1 > $DCC_PATH/config
    echo 0xC2A80E4 1 > $DCC_PATH/config
    echo 0xC2A80E8 1 > $DCC_PATH/config
    echo 0xC2A803C 1 > $DCC_PATH/config
    echo 0xC2A81A0 1 > $DCC_PATH/config
    echo 0xC2A8180 1 > $DCC_PATH/config
    echo 0xC2A8178 1 > $DCC_PATH/config
    echo 0xC2A817C 1 > $DCC_PATH/config
    echo 0xC2A8048 1 > $DCC_PATH/config
}

config_camera_debug()
{
    echo 0xADF4004 1 > $DCC_PATH/config
    echo 0xADF2004 1 > $DCC_PATH/config
    echo 0xADF3004 1 > $DCC_PATH/config
    echo 0xADF302C 1 > $DCC_PATH/config
    echo 0xADF300C 1 > $DCC_PATH/config
}

config_dcc_timer()
{
    echo 0x17421000 4 > $DCC_PATH/config
}

config_gcc_vote()
{
    echo 0x18B004 1 > $DCC_PATH/config
    echo 0x18B010 1 > $DCC_PATH/config
    echo 0x18C004 1 > $DCC_PATH/config
    echo 0x18C010 1 > $DCC_PATH/config
    echo 0x18D004 1 > $DCC_PATH/config
    echo 0x18D010 1 > $DCC_PATH/config
    echo 0x18E004 1 > $DCC_PATH/config
    echo 0x18E010 1 > $DCC_PATH/config
    echo 0x197004 1 > $DCC_PATH/config
    echo 0x197010 1 > $DCC_PATH/config
}

enable_stm_hw_events()
{
   #TODO: Add HW events
}


enable_dcc()
{
    DCC_PATH="/sys/bus/platform/devices/100ff000.dcc_v2"
    soc_version=`cat /sys/devices/soc0/revision`
    soc_version=${soc_version/./}

    if [ ! -d $DCC_PATH ]; then
        echo "DCC does not exist on this build."
        return
    fi

    echo 0 > $DCC_PATH/enable
    echo 1 > $DCC_PATH/config_reset
    echo 6 > $DCC_PATH/curr_list
    echo cap > $DCC_PATH/func_type
    echo sram > $DCC_PATH/data_sink
    config_dcc_timer
    config_dcc_tsens
    config_dcc_core
    config_dcc_smmu
    gemnoc_dump
    config_gpu
    config_dcc_lpm_pcu
    config_dcc_gic
    config_adsp
    config_dcc_apss_rscc
    config_dcc_apss_pdc
    config_dcc_ddr
    config_dcc_lpass
    config_gcc_vote
    config_dcc_timer
    config_dcc_prng

    echo 4 > $DCC_PATH/curr_list
    echo cap > $DCC_PATH/func_type
    echo sram > $DCC_PATH/data_sink
    config_dcc_timer
    dc_noc_dump
    lpass_ag_noc_dump
    mmss_noc_dump
    system_noc_dump
    aggre_noc_dump
    config_noc_dump
    config_dcc_rpmh
    config_dcc_misc
    config_dcc_epss
    config_dcc_gict
    config_cb
    config_modem
    config_wpss
    config_gcc
    config_qtimer_regs
    config_aoss_regs
    config_rdpm_llm_reg
    config_camera_debug
    config_dcc_timer

    echo  1 > $DCC_PATH/enable
}


##################################
# ACTPM trace API - usage example
##################################

actpm_traces_configure()
{
  echo ++++++++++++++++++++++++++++++++++++++
  echo actpm_traces_configure
  echo ++++++++++++++++++++++++++++++++++++++

  echo 1 > /sys/bus/coresight/devices/coresight-tpdm-actpm/reset
  ### CMB_MSR : [10]: debug_en, [7:6] : 0x0-0x3 : clkdom0-clkdom3 debug_bus
  ###         : [5]: trace_en, [4]: 0b0:continuous mode 0b1 : legacy mode
  ###         : [3:0] : legacy mode : 0x0 : combined_traces 0x1-0x4 : clkdom0-clkdom3
  echo 0 0x420 > /sys/bus/coresight/devices/coresight-tpdm-actpm/cmb_msr
  echo 0 > /sys/bus/coresight/devices/coresight-tpdm-actpm/mcmb_lanes_select
  echo 1 0 > /sys/bus/coresight/devices/coresight-tpdm-actpm/cmb_mode
  echo 1 > /sys/bus/coresight/devices/coresight-tpdm-actpm/cmb_ts_all
  echo 1 > /sys/bus/coresight/devices/coresight-tpdm-actpm/cmb_patt_ts
  echo 0 0x20000000 > /sys/bus/coresight/devices/coresight-tpdm-actpm/cmb_patt_mask
  echo 0 0x20000000 > /sys/bus/coresight/devices/coresight-tpdm-actpm/cmb_patt_val

}

actpm_traces_start()
{
  echo ++++++++++++++++++++++++++++++++++++++
  echo actpm_traces_start
  echo ++++++++++++++++++++++++++++++++++++++
  # "Start actpm Trace collection "
  echo 0x4 > /sys/bus/coresight/devices/coresight-tpdm-actpm/enable_datasets
  echo 1 > /sys/bus/coresight/devices/coresight-tpdm-actpm/enable_source
}

stm_traces_configure()
{
  echo ++++++++++++++++++++++++++++++++++++++
  echo stm_traces_configure
  echo ++++++++++++++++++++++++++++++++++++++
  echo 0 > /sys/bus/coresight/devices/coresight-stm/hwevent_enable
}

stm_traces_start()
{
  echo ++++++++++++++++++++++++++++++++++++++
  echo stm_traces_start
  echo ++++++++++++++++++++++++++++++++++++++
  echo 1 > /sys/bus/coresight/devices/coresight-stm/enable_source
}

ipm_traces_configure()
{
  echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss/reset
  echo 0x0 0x3f 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
  echo 0x0 0x3f 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
  #gic HW events
  echo 0xfb 0xfc 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl_mask
  echo 0xfb 0xfc 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_edge_ctrl
  echo 0 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
  echo 1 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
  echo 2 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
  echo 3 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
  echo 4 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
  echo 5 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
  echo 6 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
  echo 7 0x00000000  > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_msr
  echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_ts
  echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_type
  echo 0 > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_trig_ts
  echo 0 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
  echo 1 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
  echo 2 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
  echo 3 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
  echo 4 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
  echo 5 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
  echo 6 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask
  echo 7 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss/dsb_patt_mask

  echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/reset
  echo 0x0 0x2 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_edge_ctrl_mask
  echo 0x0 0x2 0 > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_edge_ctrl
  echo 0x8a 0x8b 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_edge_ctrl_mask
  echo 0x8a 0x8b 0 > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_edge_ctrl
  echo 0xb8 0xca 0x1 > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_edge_ctrl_mask
  echo 0xb8 0xca 0 > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_edge_ctrl
  echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_patt_ts
  echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_patt_type
  echo 0 > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_trig_ts
  echo 0 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_patt_mask
  echo 1 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_patt_mask
  echo 2 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_patt_mask
  echo 3 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_patt_mask
  echo 4 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_patt_mask
  echo 5 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_patt_mask
  echo 6 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_patt_mask
  echo 7 0xFFFFFFFF > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/dsb_patt_mask

}

ipm_traces_start()
{
  # "Start ipm Trace collection "
  echo 2 > /sys/bus/coresight/devices/coresight-tpdm-apss/enable_datasets
  echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss/enable_source
  echo 2 > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/enable_datasets
  echo 1 > /sys/bus/coresight/devices/coresight-tpdm-apss-llm/enable_source

}

enable_cpuss_hw_events()
{
    actpm_traces_configure
    ipm_traces_configure
    stm_traces_configure

    ipm_traces_start
    stm_traces_start
    actpm_traces_start
}

enable_core_hang_config()
{
    CORE_PATH="/sys/devices/system/cpu/hang_detect_core"
    if [ ! -d $CORE_PATH ]; then
        echo "CORE hang does not exist on this build."
        return
    fi

    #set the threshold to max
    echo 0xffffffff > $CORE_PATH/threshold

    #To enable core hang detection
    #It's a boolean variable. Do not use Hex value to enable/disable
    echo 1 > $CORE_PATH/enable
}

adjust_permission()
{
    #add permission for block_size, mem_type, mem_size nodes to collect diag over QDSS by ODL
    #application by "oem_2902" group
    chown -h root.oem_2902 /sys/devices/platform/soc/10048000.tmc/coresight-tmc-etr/block_size
    chmod 660 /sys/devices/platform/soc/10048000.tmc/coresight-tmc-etr/block_size
    chown -h root.oem_2902 /sys/devices/platform/soc/10048000.tmc/coresight-tmc-etr/buffer_size
    chmod 660 /sys/devices/platform/soc/10048000.tmc/coresight-tmc-etr/buffer_size
}

enable_schedstats()
{
    # bail out if its perf config
    if [ ! -d /sys/module/msm_rtb ]
    then
        return
    fi

    if [ -f /proc/sys/kernel/sched_schedstats ]
    then
        echo 1 > /proc/sys/kernel/sched_schedstats
    fi
}

configure_cpuss_reg()
{
    echo 0x17000000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17000008 0x48 > $MEM_DUMP_PATH/register_config
    echo 0x17000054 0x1c > $MEM_DUMP_PATH/register_config
    echo 0x170000f0 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17008000 0x14 > $MEM_DUMP_PATH/register_config
    echo 0x17200000 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17200020 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17200084 0x74 > $MEM_DUMP_PATH/register_config
    echo 0x17200104 0x74 > $MEM_DUMP_PATH/register_config
    echo 0x17200184 0x74 > $MEM_DUMP_PATH/register_config
    echo 0x17200204 0x74 > $MEM_DUMP_PATH/register_config
    echo 0x17200284 0x74 > $MEM_DUMP_PATH/register_config
    echo 0x17200304 0x74 > $MEM_DUMP_PATH/register_config
    echo 0x17200384 0x74 > $MEM_DUMP_PATH/register_config
    echo 0x17200420 0x3a0 > $MEM_DUMP_PATH/register_config
    echo 0x17200c08 0xe8 > $MEM_DUMP_PATH/register_config
    echo 0x17200d04 0x74 > $MEM_DUMP_PATH/register_config
    echo 0x17200e08 0xe8 > $MEM_DUMP_PATH/register_config
    echo 0x17206100 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206108 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206110 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206118 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206120 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206128 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206130 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206138 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206140 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206148 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206150 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206158 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206160 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206168 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206170 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206178 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206180 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206188 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206190 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206198 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172061a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172061a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172061b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172061b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172061c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172061c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172061d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172061d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172061e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172061e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172061f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172061f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206200 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206208 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206210 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206218 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206220 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206228 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206230 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206238 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206240 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206248 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206250 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206258 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206260 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206268 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206270 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206278 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206280 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206288 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206290 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206298 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172062a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172062a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172062b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172062b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172062c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172062c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172062d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172062d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172062e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172062e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172062f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172062f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206300 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206308 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206310 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206318 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206320 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206328 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206330 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206338 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206340 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206348 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206350 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206358 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206360 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206368 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206370 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206378 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206380 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206388 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206390 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206398 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172063a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172063a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172063b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172063b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172063c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172063c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172063d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172063d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172063e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172063e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172063f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172063f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206400 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206408 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206410 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206418 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206420 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206428 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206430 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206438 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206440 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206448 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206450 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206458 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206460 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206468 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206470 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206478 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206480 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206488 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206490 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206498 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172064a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172064a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172064b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172064b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172064c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172064c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172064d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172064d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172064e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172064e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172064f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172064f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206500 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206508 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206510 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206518 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206520 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206528 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206530 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206538 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206540 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206548 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206550 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206558 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206560 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206568 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206570 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206578 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206580 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206588 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206590 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206598 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172065a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172065a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172065b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172065b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172065c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172065c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172065d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172065d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172065e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172065e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172065f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172065f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206600 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206608 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206610 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206618 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206620 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206628 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206630 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206638 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206640 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206648 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206650 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206658 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206660 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206668 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206670 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206678 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206680 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206688 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206690 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206698 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172066a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172066a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172066b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172066b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172066c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172066c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172066d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172066d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172066e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172066e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172066f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172066f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206700 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206708 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206710 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206718 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206720 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206728 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206730 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206738 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206740 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206748 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206750 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206758 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206760 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206768 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206770 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206778 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206780 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206788 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206790 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206798 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172067a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172067a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172067b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172067b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172067c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172067c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172067d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172067d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172067e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172067e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172067f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172067f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206800 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206808 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206810 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206818 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206820 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206828 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206830 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206838 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206840 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206848 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206850 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206858 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206860 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206868 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206870 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206878 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206880 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206888 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206890 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206898 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172068a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172068a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172068b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172068b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172068c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172068c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172068d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172068d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172068e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172068e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172068f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172068f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206900 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206908 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206910 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206918 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206920 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206928 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206930 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206938 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206940 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206948 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206950 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206958 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206960 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206968 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206970 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206978 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206980 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206988 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206990 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206998 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172069a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172069a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172069b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172069b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172069c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172069c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172069d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172069d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172069e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172069e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172069f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172069f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206a00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206a08 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206a10 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206a18 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206a20 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206a28 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206a30 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206a38 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206a40 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206a48 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206a50 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206a58 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206a60 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206a68 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206a70 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206a78 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206a80 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206a88 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206a90 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206a98 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206aa0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206aa8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ab0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ab8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ac0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ac8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ad0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ad8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ae0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ae8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206af0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206af8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206b00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206b08 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206b10 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206b18 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206b20 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206b28 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206b30 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206b38 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206b40 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206b48 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206b50 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206b58 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206b60 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206b68 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206b70 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206b78 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206b80 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206b88 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206b90 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206b98 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ba0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ba8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206bb0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206bb8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206bc0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206bc8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206bd0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206bd8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206be0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206be8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206bf0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206bf8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206c00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206c08 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206c10 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206c18 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206c20 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206c28 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206c30 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206c38 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206c40 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206c48 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206c50 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206c58 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206c60 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206c68 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206c70 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206c78 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206c80 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206c88 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206c90 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206c98 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ca0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ca8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206cb0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206cb8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206cc0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206cc8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206cd0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206cd8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ce0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ce8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206cf0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206cf8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206d00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206d08 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206d10 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206d18 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206d20 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206d28 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206d30 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206d38 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206d40 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206d48 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206d50 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206d58 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206d60 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206d68 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206d70 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206d78 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206d80 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206d88 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206d90 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206d98 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206da0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206da8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206db0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206db8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206dc0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206dc8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206dd0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206dd8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206de0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206de8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206df0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206df8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206e00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206e08 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206e10 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206e18 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206e20 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206e28 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206e30 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206e38 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206e40 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206e48 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206e50 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206e58 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206e60 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206e68 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206e70 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206e78 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206e80 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206e88 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206e90 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206e98 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ea0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ea8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206eb0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206eb8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ec0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ec8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ed0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ed8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ee0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ee8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ef0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ef8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206f00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206f08 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206f10 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206f18 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206f20 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206f28 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206f30 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206f38 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206f40 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206f48 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206f50 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206f58 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206f60 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206f68 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206f70 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206f78 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206f80 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206f88 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206f90 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206f98 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206fa0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206fa8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206fb0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206fb8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206fc0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206fc8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206fd0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206fd8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206fe0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206fe8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ff0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17206ff8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207008 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207010 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207018 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207020 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207028 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207030 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207038 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207040 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207048 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207050 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207058 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207060 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207068 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207070 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207078 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207080 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207088 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207090 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207098 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172070a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172070a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172070b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172070b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172070c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172070c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172070d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172070d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172070e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172070e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172070f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172070f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207100 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207108 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207110 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207118 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207120 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207128 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207130 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207138 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207140 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207148 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207150 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207158 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207160 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207168 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207170 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207178 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207180 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207188 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207190 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207198 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172071a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172071a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172071b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172071b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172071c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172071c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172071d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172071d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172071e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172071e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172071f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172071f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207200 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207208 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207210 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207218 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207220 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207228 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207230 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207238 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207240 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207248 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207250 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207258 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207260 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207268 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207270 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207278 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207280 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207288 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207290 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207298 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172072a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172072a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172072b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172072b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172072c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172072c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172072d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172072d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172072e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172072e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172072f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172072f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207300 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207308 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207310 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207318 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207320 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207328 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207330 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207338 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207340 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207348 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207350 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207358 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207360 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207368 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207370 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207378 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207380 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207388 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207390 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207398 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172073a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172073a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172073b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172073b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172073c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172073c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172073d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172073d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172073e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172073e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172073f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172073f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207400 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207408 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207410 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207418 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207420 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207428 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207430 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207438 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207440 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207448 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207450 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207458 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207460 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207468 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207470 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207478 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207480 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207488 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207490 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207498 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172074a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172074a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172074b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172074b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172074c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172074c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172074d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172074d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172074e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172074e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172074f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172074f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207500 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207508 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207510 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207518 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207520 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207528 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207530 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207538 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207540 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207548 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207550 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207558 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207560 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207568 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207570 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207578 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207580 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207588 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207590 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207598 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172075a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172075a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172075b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172075b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172075c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172075c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172075d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172075d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172075e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172075e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172075f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172075f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207600 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207608 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207610 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207618 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207620 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207628 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207630 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207638 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207640 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207648 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207650 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207658 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207660 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207668 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207670 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207678 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207680 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207688 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207690 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207698 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172076a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172076a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172076b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172076b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172076c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172076c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172076d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172076d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172076e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172076e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172076f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172076f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207700 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207708 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207710 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207718 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207720 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207728 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207730 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207738 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207740 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207748 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207750 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207758 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207760 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207768 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207770 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207778 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207780 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207788 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207790 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207798 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172077a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172077a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172077b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172077b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172077c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172077c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172077d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172077d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172077e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172077e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172077f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172077f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207800 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207808 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207810 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207818 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207820 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207828 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207830 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207838 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207840 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207848 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207850 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207858 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207860 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207868 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207870 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207878 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207880 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207888 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207890 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207898 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172078a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172078a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172078b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172078b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172078c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172078c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172078d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172078d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172078e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172078e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172078f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172078f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207900 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207908 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207910 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207918 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207920 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207928 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207930 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207938 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207940 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207948 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207950 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207958 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207960 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207968 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207970 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207978 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207980 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207988 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207990 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207998 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172079a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172079a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172079b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172079b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172079c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172079c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172079d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172079d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172079e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172079e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172079f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172079f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207a00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207a08 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207a10 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207a18 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207a20 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207a28 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207a30 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207a38 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207a40 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207a48 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207a50 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207a58 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207a60 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207a68 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207a70 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207a78 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207a80 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207a88 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207a90 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207a98 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207aa0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207aa8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207ab0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207ab8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207ac0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207ac8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207ad0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207ad8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207ae0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207ae8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207af0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207af8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207b00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207b08 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207b10 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207b18 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207b20 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207b28 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207b30 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207b38 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207b40 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207b48 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207b50 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207b58 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207b60 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207b68 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207b70 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207b78 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207b80 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207b88 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207b90 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207b98 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207ba0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207ba8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207bb0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207bb8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207bc0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207bc8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207bd0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207bd8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207be0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207be8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207bf0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207bf8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207c00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207c08 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207c10 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207c18 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207c20 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207c28 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207c30 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207c38 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207c40 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207c48 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207c50 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207c58 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207c60 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207c68 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207c70 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207c78 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207c80 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207c88 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207c90 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207c98 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207ca0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207ca8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207cb0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207cb8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207cc0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207cc8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207cd0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207cd8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207ce0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207ce8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207cf0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207cf8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207d00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207d08 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207d10 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207d18 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207d20 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207d28 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207d30 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207d38 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207d40 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207d48 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207d50 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207d58 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207d60 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207d68 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207d70 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207d78 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207d80 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207d88 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207d90 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207d98 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207da0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207da8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207db0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207db8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207dc0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207dc8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207dd0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207dd8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207de0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207de8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207df0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17207df8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1720e008 0xe8 > $MEM_DUMP_PATH/register_config
    echo 0x1720e104 0x74 > $MEM_DUMP_PATH/register_config
    echo 0x1720f000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1720ffd0 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17220000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220008 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220010 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220018 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220020 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220028 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220040 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220048 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220050 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220060 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220068 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220080 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220088 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220090 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172200a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172200a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172200c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172200c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172200d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172200e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172200e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220100 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220108 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220110 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220120 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220128 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220140 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220148 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220150 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220160 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220168 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220180 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220188 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220190 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172201a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172201a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172201c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172201c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172201d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172201e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172201e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220200 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220208 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220210 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220220 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220228 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220240 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220248 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220250 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220260 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220268 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220280 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220288 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220290 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172202a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172202a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172202c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172202c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172202d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172202e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172202e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220300 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220308 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220310 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220320 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220328 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220340 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220348 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220350 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220360 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17220368 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1722e000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1722e800 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1722e808 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1722ffbc 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1722ffc8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1722ffd0 0x44 > $MEM_DUMP_PATH/register_config
    echo 0x17230400 0x14 > $MEM_DUMP_PATH/register_config
    echo 0x17230600 0x14 > $MEM_DUMP_PATH/register_config
    echo 0x17230a00 0x14 > $MEM_DUMP_PATH/register_config
    echo 0x17230c00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17230c20 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17230c40 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17230c60 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17230c80 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17230cc0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17230e00 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17230e50 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17230fb8 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17230fcc 0x34 > $MEM_DUMP_PATH/register_config
    echo 0x17240000 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17240020 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17240028 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17240030 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17240080 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17240088 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17240090 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17240100 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17240108 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1724f000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1724ffd0 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17260000 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17260014 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17260020 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17260070 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17260078 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1726ffd0 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17270080 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17270100 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17270180 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17270200 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17270280 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17270300 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17270380 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17270400 0x20 > $MEM_DUMP_PATH/register_config
    echo 0x17270c00 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17270d00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17270e00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1727c000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1727c008 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1727c010 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1727f000 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17280000 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17280014 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17280020 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17280070 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17280078 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1728ffd0 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17290080 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17290100 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17290180 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17290200 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17290280 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17290300 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17290380 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17290400 0x20 > $MEM_DUMP_PATH/register_config
    echo 0x17290c00 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17290d00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17290e00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1729c000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1729c008 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1729c010 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1729f000 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x172a0000 0xc > $MEM_DUMP_PATH/register_config
    echo 0x172a0014 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172a0020 0xc > $MEM_DUMP_PATH/register_config
    echo 0x172a0070 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172a0078 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172affd0 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x172b0080 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172b0100 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172b0180 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172b0200 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172b0280 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172b0300 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172b0380 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172b0400 0x20 > $MEM_DUMP_PATH/register_config
    echo 0x172b0c00 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x172b0d00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172b0e00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172bc000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172bc008 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172bc010 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172bf000 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x172c0000 0xc > $MEM_DUMP_PATH/register_config
    echo 0x172c0014 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172c0020 0xc > $MEM_DUMP_PATH/register_config
    echo 0x172c0070 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172c0078 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172cffd0 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x172d0080 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172d0100 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172d0180 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172d0200 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172d0280 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172d0300 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172d0380 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172d0400 0x20 > $MEM_DUMP_PATH/register_config
    echo 0x172d0c00 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x172d0d00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172d0e00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172dc000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172dc008 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172dc010 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172df000 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x172e0000 0xc > $MEM_DUMP_PATH/register_config
    echo 0x172e0014 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172e0020 0xc > $MEM_DUMP_PATH/register_config
    echo 0x172e0070 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172e0078 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172effd0 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x172f0080 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172f0100 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172f0180 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172f0200 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172f0280 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172f0300 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172f0380 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172f0400 0x20 > $MEM_DUMP_PATH/register_config
    echo 0x172f0c00 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x172f0d00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172f0e00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172fc000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172fc008 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172fc010 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x172ff000 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17300000 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17300014 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17300020 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17300070 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17300078 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1730ffd0 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17310080 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17310100 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17310180 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17310200 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17310280 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17310300 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17310380 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17310400 0x20 > $MEM_DUMP_PATH/register_config
    echo 0x17310c00 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17310d00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17310e00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1731c000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1731c008 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1731c010 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1731f000 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17320000 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17320014 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17320020 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17320070 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17320078 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1732ffd0 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17330080 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17330100 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17330180 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17330200 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17330280 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17330300 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17330380 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17330400 0x20 > $MEM_DUMP_PATH/register_config
    echo 0x17330c00 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17330d00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17330e00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1733c000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1733c008 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1733c010 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1733f000 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17340000 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17340014 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17340020 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17340070 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17340078 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1734ffd0 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17350080 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17350100 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17350180 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17350200 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17350280 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17350300 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17350380 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17350400 0x20 > $MEM_DUMP_PATH/register_config
    echo 0x17350c00 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17350d00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17350e00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1735c000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1735c008 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1735c010 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1735f000 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17360000 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17360020 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17360084 0x74 > $MEM_DUMP_PATH/register_config
    echo 0x17360104 0x74 > $MEM_DUMP_PATH/register_config
    echo 0x17360184 0x74 > $MEM_DUMP_PATH/register_config
    echo 0x17360204 0x74 > $MEM_DUMP_PATH/register_config
    echo 0x17360284 0x74 > $MEM_DUMP_PATH/register_config
    echo 0x17360304 0x74 > $MEM_DUMP_PATH/register_config
    echo 0x17360384 0x74 > $MEM_DUMP_PATH/register_config
    echo 0x17360420 0x3a0 > $MEM_DUMP_PATH/register_config
    echo 0x17360c08 0xe8 > $MEM_DUMP_PATH/register_config
    echo 0x17360d04 0x74 > $MEM_DUMP_PATH/register_config
    echo 0x17360e08 0xe8 > $MEM_DUMP_PATH/register_config
    echo 0x17366100 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366108 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366110 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366118 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366120 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366128 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366130 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366138 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366140 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366148 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366150 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366158 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366160 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366168 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366170 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366178 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366180 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366188 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366190 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366198 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173661a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173661a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173661b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173661b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173661c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173661c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173661d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173661d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173661e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173661e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173661f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173661f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366200 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366208 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366210 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366218 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366220 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366228 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366230 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366238 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366240 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366248 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366250 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366258 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366260 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366268 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366270 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366278 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366280 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366288 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366290 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366298 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173662a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173662a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173662b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173662b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173662c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173662c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173662d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173662d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173662e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173662e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173662f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173662f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366300 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366308 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366310 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366318 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366320 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366328 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366330 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366338 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366340 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366348 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366350 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366358 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366360 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366368 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366370 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366378 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366380 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366388 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366390 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366398 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173663a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173663a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173663b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173663b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173663c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173663c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173663d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173663d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173663e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173663e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173663f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173663f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366400 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366408 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366410 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366418 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366420 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366428 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366430 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366438 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366440 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366448 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366450 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366458 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366460 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366468 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366470 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366478 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366480 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366488 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366490 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366498 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173664a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173664a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173664b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173664b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173664c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173664c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173664d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173664d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173664e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173664e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173664f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173664f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366500 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366508 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366510 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366518 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366520 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366528 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366530 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366538 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366540 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366548 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366550 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366558 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366560 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366568 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366570 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366578 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366580 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366588 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366590 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366598 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173665a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173665a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173665b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173665b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173665c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173665c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173665d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173665d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173665e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173665e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173665f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173665f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366600 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366608 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366610 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366618 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366620 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366628 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366630 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366638 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366640 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366648 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366650 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366658 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366660 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366668 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366670 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366678 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366680 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366688 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366690 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366698 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173666a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173666a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173666b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173666b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173666c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173666c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173666d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173666d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173666e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173666e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173666f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173666f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366700 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366708 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366710 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366718 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366720 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366728 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366730 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366738 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366740 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366748 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366750 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366758 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366760 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366768 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366770 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366778 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366780 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366788 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366790 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366798 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173667a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173667a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173667b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173667b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173667c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173667c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173667d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173667d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173667e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173667e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173667f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173667f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366800 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366808 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366810 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366818 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366820 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366828 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366830 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366838 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366840 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366848 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366850 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366858 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366860 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366868 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366870 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366878 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366880 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366888 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366890 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366898 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173668a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173668a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173668b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173668b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173668c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173668c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173668d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173668d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173668e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173668e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173668f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173668f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366900 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366908 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366910 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366918 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366920 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366928 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366930 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366938 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366940 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366948 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366950 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366958 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366960 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366968 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366970 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366978 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366980 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366988 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366990 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366998 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173669a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173669a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173669b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173669b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173669c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173669c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173669d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173669d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173669e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173669e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173669f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173669f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366a00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366a08 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366a10 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366a18 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366a20 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366a28 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366a30 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366a38 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366a40 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366a48 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366a50 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366a58 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366a60 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366a68 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366a70 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366a78 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366a80 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366a88 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366a90 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366a98 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366aa0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366aa8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ab0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ab8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ac0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ac8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ad0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ad8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ae0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ae8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366af0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366af8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366b00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366b08 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366b10 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366b18 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366b20 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366b28 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366b30 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366b38 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366b40 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366b48 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366b50 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366b58 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366b60 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366b68 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366b70 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366b78 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366b80 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366b88 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366b90 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366b98 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ba0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ba8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366bb0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366bb8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366bc0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366bc8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366bd0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366bd8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366be0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366be8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366bf0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366bf8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366c00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366c08 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366c10 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366c18 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366c20 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366c28 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366c30 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366c38 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366c40 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366c48 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366c50 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366c58 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366c60 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366c68 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366c70 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366c78 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366c80 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366c88 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366c90 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366c98 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ca0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ca8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366cb0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366cb8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366cc0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366cc8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366cd0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366cd8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ce0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ce8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366cf0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366cf8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366d00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366d08 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366d10 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366d18 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366d20 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366d28 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366d30 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366d38 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366d40 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366d48 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366d50 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366d58 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366d60 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366d68 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366d70 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366d78 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366d80 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366d88 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366d90 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366d98 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366da0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366da8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366db0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366db8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366dc0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366dc8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366dd0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366dd8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366de0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366de8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366df0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366df8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366e00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366e08 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366e10 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366e18 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366e20 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366e28 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366e30 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366e38 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366e40 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366e48 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366e50 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366e58 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366e60 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366e68 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366e70 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366e78 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366e80 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366e88 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366e90 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366e98 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ea0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ea8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366eb0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366eb8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ec0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ec8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ed0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ed8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ee0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ee8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ef0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ef8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366f00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366f08 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366f10 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366f18 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366f20 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366f28 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366f30 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366f38 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366f40 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366f48 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366f50 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366f58 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366f60 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366f68 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366f70 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366f78 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366f80 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366f88 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366f90 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366f98 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366fa0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366fa8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366fb0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366fb8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366fc0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366fc8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366fd0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366fd8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366fe0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366fe8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ff0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17366ff8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367008 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367010 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367018 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367020 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367028 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367030 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367038 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367040 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367048 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367050 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367058 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367060 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367068 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367070 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367078 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367080 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367088 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367090 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367098 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173670a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173670a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173670b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173670b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173670c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173670c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173670d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173670d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173670e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173670e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173670f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173670f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367100 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367108 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367110 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367118 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367120 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367128 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367130 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367138 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367140 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367148 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367150 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367158 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367160 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367168 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367170 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367178 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367180 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367188 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367190 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367198 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173671a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173671a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173671b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173671b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173671c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173671c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173671d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173671d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173671e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173671e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173671f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173671f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367200 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367208 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367210 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367218 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367220 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367228 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367230 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367238 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367240 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367248 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367250 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367258 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367260 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367268 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367270 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367278 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367280 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367288 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367290 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367298 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173672a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173672a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173672b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173672b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173672c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173672c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173672d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173672d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173672e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173672e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173672f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173672f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367300 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367308 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367310 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367318 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367320 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367328 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367330 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367338 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367340 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367348 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367350 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367358 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367360 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367368 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367370 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367378 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367380 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367388 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367390 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367398 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173673a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173673a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173673b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173673b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173673c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173673c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173673d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173673d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173673e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173673e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173673f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173673f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367400 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367408 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367410 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367418 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367420 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367428 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367430 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367438 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367440 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367448 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367450 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367458 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367460 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367468 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367470 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367478 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367480 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367488 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367490 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367498 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173674a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173674a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173674b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173674b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173674c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173674c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173674d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173674d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173674e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173674e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173674f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173674f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367500 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367508 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367510 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367518 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367520 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367528 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367530 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367538 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367540 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367548 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367550 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367558 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367560 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367568 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367570 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367578 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367580 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367588 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367590 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367598 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173675a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173675a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173675b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173675b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173675c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173675c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173675d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173675d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173675e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173675e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173675f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173675f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367600 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367608 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367610 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367618 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367620 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367628 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367630 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367638 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367640 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367648 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367650 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367658 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367660 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367668 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367670 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367678 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367680 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367688 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367690 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367698 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173676a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173676a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173676b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173676b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173676c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173676c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173676d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173676d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173676e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173676e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173676f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173676f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367700 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367708 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367710 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367718 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367720 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367728 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367730 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367738 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367740 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367748 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367750 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367758 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367760 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367768 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367770 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367778 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367780 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367788 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367790 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367798 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173677a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173677a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173677b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173677b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173677c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173677c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173677d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173677d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173677e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173677e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173677f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173677f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367800 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367808 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367810 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367818 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367820 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367828 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367830 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367838 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367840 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367848 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367850 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367858 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367860 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367868 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367870 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367878 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367880 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367888 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367890 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367898 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173678a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173678a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173678b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173678b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173678c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173678c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173678d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173678d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173678e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173678e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173678f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173678f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367900 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367908 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367910 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367918 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367920 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367928 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367930 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367938 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367940 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367948 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367950 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367958 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367960 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367968 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367970 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367978 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367980 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367988 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367990 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367998 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173679a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173679a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173679b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173679b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173679c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173679c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173679d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173679d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173679e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173679e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173679f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x173679f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367a00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367a08 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367a10 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367a18 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367a20 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367a28 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367a30 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367a38 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367a40 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367a48 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367a50 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367a58 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367a60 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367a68 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367a70 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367a78 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367a80 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367a88 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367a90 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367a98 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367aa0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367aa8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367ab0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367ab8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367ac0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367ac8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367ad0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367ad8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367ae0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367ae8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367af0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367af8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367b00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367b08 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367b10 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367b18 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367b20 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367b28 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367b30 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367b38 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367b40 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367b48 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367b50 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367b58 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367b60 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367b68 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367b70 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367b78 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367b80 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367b88 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367b90 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367b98 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367ba0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367ba8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367bb0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367bb8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367bc0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367bc8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367bd0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367bd8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367be0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367be8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367bf0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367bf8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367c00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367c08 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367c10 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367c18 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367c20 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367c28 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367c30 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367c38 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367c40 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367c48 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367c50 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367c58 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367c60 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367c68 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367c70 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367c78 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367c80 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367c88 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367c90 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367c98 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367ca0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367ca8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367cb0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367cb8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367cc0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367cc8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367cd0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367cd8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367ce0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367ce8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367cf0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367cf8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367d00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367d08 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367d10 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367d18 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367d20 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367d28 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367d30 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367d38 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367d40 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367d48 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367d50 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367d58 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367d60 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367d68 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367d70 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367d78 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367d80 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367d88 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367d90 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367d98 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367da0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367da8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367db0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367db8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367dc0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367dc8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367dd0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367dd8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367de0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367de8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367df0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17367df8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1736e008 0xe8 > $MEM_DUMP_PATH/register_config
    echo 0x1736e104 0x74 > $MEM_DUMP_PATH/register_config
    echo 0x1736f000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1736ffd0 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17400004 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17400038 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17400044 0xc > $MEM_DUMP_PATH/register_config
    echo 0x174000f0 0x74 > $MEM_DUMP_PATH/register_config
    echo 0x17400200 0x64 > $MEM_DUMP_PATH/register_config
    echo 0x17400438 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17400444 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17410000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1741000c 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17410020 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17411000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1741100c 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17411020 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17420000 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17420040 0x1c > $MEM_DUMP_PATH/register_config
    echo 0x17420080 0x38 > $MEM_DUMP_PATH/register_config
    echo 0x17420fc0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17420fd0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17420fe0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17420ff0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17421000 0x40 > $MEM_DUMP_PATH/register_config
    echo 0x17421fd0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17422000 0x14 > $MEM_DUMP_PATH/register_config
    echo 0x17422020 0x20 > $MEM_DUMP_PATH/register_config
    echo 0x17422fd0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17423000 0x40 > $MEM_DUMP_PATH/register_config
    echo 0x17423fd0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17425000 0x40 > $MEM_DUMP_PATH/register_config
    echo 0x17425fd0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17426000 0x14 > $MEM_DUMP_PATH/register_config
    echo 0x17426020 0x20 > $MEM_DUMP_PATH/register_config
    echo 0x17426fd0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17427000 0x40 > $MEM_DUMP_PATH/register_config
    echo 0x17427fd0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17429000 0x40 > $MEM_DUMP_PATH/register_config
    echo 0x17429fd0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1742b000 0x40 > $MEM_DUMP_PATH/register_config
    echo 0x1742bfd0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1742d000 0x40 > $MEM_DUMP_PATH/register_config
    echo 0x1742dfd0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17600004 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17600010 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17600024 0x14 > $MEM_DUMP_PATH/register_config
    echo 0x17600040 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17600050 0x14 > $MEM_DUMP_PATH/register_config
    echo 0x17600070 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17600160 0x40 > $MEM_DUMP_PATH/register_config
    echo 0x17600204 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17600210 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17600230 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17600240 0x40 > $MEM_DUMP_PATH/register_config
    echo 0x176002a4 0xc > $MEM_DUMP_PATH/register_config
    echo 0x176002b4 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17600404 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1760041c 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17600434 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1760043c 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17600448 0x28 > $MEM_DUMP_PATH/register_config
    echo 0x17600474 0x5c > $MEM_DUMP_PATH/register_config
    echo 0x176004d4 0x128 > $MEM_DUMP_PATH/register_config
    echo 0x1760061c 0xc4 > $MEM_DUMP_PATH/register_config
    echo 0x17606000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17607000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17608004 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17608018 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17608028 0xc > $MEM_DUMP_PATH/register_config
    echo 0x1760f000 0x18 > $MEM_DUMP_PATH/register_config
    echo 0x17800000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17800008 0x48 > $MEM_DUMP_PATH/register_config
    echo 0x17800054 0x1c > $MEM_DUMP_PATH/register_config
    echo 0x178000f0 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17810000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17810008 0x48 > $MEM_DUMP_PATH/register_config
    echo 0x17810054 0x1c > $MEM_DUMP_PATH/register_config
    echo 0x178100f0 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17820000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17820008 0x48 > $MEM_DUMP_PATH/register_config
    echo 0x17820054 0x1c > $MEM_DUMP_PATH/register_config
    echo 0x178200f0 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17830000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17830008 0x48 > $MEM_DUMP_PATH/register_config
    echo 0x17830054 0x1c > $MEM_DUMP_PATH/register_config
    echo 0x178300f0 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17840000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17840008 0x48 > $MEM_DUMP_PATH/register_config
    echo 0x17840054 0x1c > $MEM_DUMP_PATH/register_config
    echo 0x178400f0 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17850000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17850008 0x48 > $MEM_DUMP_PATH/register_config
    echo 0x17850054 0x1c > $MEM_DUMP_PATH/register_config
    echo 0x178500f0 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17860000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17860008 0x48 > $MEM_DUMP_PATH/register_config
    echo 0x17860054 0x1c > $MEM_DUMP_PATH/register_config
    echo 0x178600f0 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17868000 0x14 > $MEM_DUMP_PATH/register_config
    echo 0x17870000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17870008 0x48 > $MEM_DUMP_PATH/register_config
    echo 0x17870054 0x1c > $MEM_DUMP_PATH/register_config
    echo 0x178700f0 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17878000 0x14 > $MEM_DUMP_PATH/register_config
    echo 0x17880000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17880008 0x48 > $MEM_DUMP_PATH/register_config
    echo 0x17880054 0x34 > $MEM_DUMP_PATH/register_config
    echo 0x17880090 0xac > $MEM_DUMP_PATH/register_config
    echo 0x17880140 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x1788019c 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x178801b0 0x1c > $MEM_DUMP_PATH/register_config
    echo 0x178801f0 0x14 > $MEM_DUMP_PATH/register_config
    echo 0x17880250 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x178c0000 0x248 > $MEM_DUMP_PATH/register_config
    echo 0x178c8000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c8008 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c8010 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c8018 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c8020 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c8028 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c8030 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c8038 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c8040 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c8048 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c8050 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c8058 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c8060 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c8068 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c8070 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c8078 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c8080 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c8088 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c8090 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c8098 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c80a0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c80a8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c80b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c80b8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c80c0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c80c8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c80d0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c80d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c80e0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c80e8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c80f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c80f8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c8100 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c8108 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c8110 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178c8118 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178cc000 0x24 > $MEM_DUMP_PATH/register_config
    echo 0x178cc030 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x178cc040 0x48 > $MEM_DUMP_PATH/register_config
    echo 0x178cc090 0x88 > $MEM_DUMP_PATH/register_config
    echo 0x17900000 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x1790000c 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17900040 0x18 > $MEM_DUMP_PATH/register_config
    echo 0x17900900 0x14 > $MEM_DUMP_PATH/register_config
    echo 0x17900c00 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17900c0c 0x18 > $MEM_DUMP_PATH/register_config
    echo 0x17900c40 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17900fd0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17a00000 0xd4 > $MEM_DUMP_PATH/register_config
    echo 0x17a000d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17a00100 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17a00200 0x14 > $MEM_DUMP_PATH/register_config
    echo 0x17a00224 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a00244 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a00264 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a00284 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a002a4 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a002c4 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a002e4 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a00400 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17a00450 0x18 > $MEM_DUMP_PATH/register_config
    echo 0x17a00490 0x2c > $MEM_DUMP_PATH/register_config
    echo 0x17a00500 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a00600 0x200 > $MEM_DUMP_PATH/register_config
    echo 0x17a00d00 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17a00d10 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a00d30 0x140 > $MEM_DUMP_PATH/register_config
    echo 0x17a00fb0 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a00fd0 0x140 > $MEM_DUMP_PATH/register_config
    echo 0x17a01250 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a01270 0x140 > $MEM_DUMP_PATH/register_config
    echo 0x17a014f0 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a01510 0x140 > $MEM_DUMP_PATH/register_config
    echo 0x17a03d44 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17a03d4c 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17a10000 0x4c > $MEM_DUMP_PATH/register_config
    echo 0x17a10050 0x84 > $MEM_DUMP_PATH/register_config
    echo 0x17a100d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17a10100 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17a10108 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17a10204 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a10224 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a10244 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a10264 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a10284 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a102a4 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a102c4 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a102e4 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a10400 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17a10450 0x18 > $MEM_DUMP_PATH/register_config
    echo 0x17a104a0 0x1c > $MEM_DUMP_PATH/register_config
    echo 0x17a10500 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a10600 0x200 > $MEM_DUMP_PATH/register_config
    echo 0x17a10d00 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17a10d10 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a10d30 0x140 > $MEM_DUMP_PATH/register_config
    echo 0x17a10fb0 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a10fd0 0x140 > $MEM_DUMP_PATH/register_config
    echo 0x17a11250 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a11270 0x140 > $MEM_DUMP_PATH/register_config
    echo 0x17a114f0 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a11510 0x140 > $MEM_DUMP_PATH/register_config
    echo 0x17a13d44 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17a13d4c 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17a13e00 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17a20000 0x4c > $MEM_DUMP_PATH/register_config
    echo 0x17a20050 0x84 > $MEM_DUMP_PATH/register_config
    echo 0x17a200d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17a20100 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17a20108 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17a20204 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a20224 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a20244 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a20264 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a20284 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a202a4 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a202c4 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a202e4 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a20400 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17a20450 0x18 > $MEM_DUMP_PATH/register_config
    echo 0x17a204a0 0x1c > $MEM_DUMP_PATH/register_config
    echo 0x17a20500 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a20600 0x200 > $MEM_DUMP_PATH/register_config
    echo 0x17a20d00 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17a20d10 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a20d30 0x140 > $MEM_DUMP_PATH/register_config
    echo 0x17a20fb0 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a20fd0 0x140 > $MEM_DUMP_PATH/register_config
    echo 0x17a21250 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a21270 0x140 > $MEM_DUMP_PATH/register_config
    echo 0x17a214f0 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a21510 0x140 > $MEM_DUMP_PATH/register_config
    echo 0x17a21790 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a217b0 0x140 > $MEM_DUMP_PATH/register_config
    echo 0x17a21a30 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a21a50 0x140 > $MEM_DUMP_PATH/register_config
    echo 0x17a21cd0 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a21cf0 0x140 > $MEM_DUMP_PATH/register_config
    echo 0x17a21f70 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a21f90 0x140 > $MEM_DUMP_PATH/register_config
    echo 0x17a23d44 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17a23d4c 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17a23e00 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17a30000 0x4c > $MEM_DUMP_PATH/register_config
    echo 0x17a30050 0x84 > $MEM_DUMP_PATH/register_config
    echo 0x17a300d8 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17a30100 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17a30108 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17a30204 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a30224 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a30244 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a30264 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a30284 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a302a4 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a302c4 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a302e4 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a30400 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17a30450 0x18 > $MEM_DUMP_PATH/register_config
    echo 0x17a304a0 0x1c > $MEM_DUMP_PATH/register_config
    echo 0x17a30500 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a30600 0x200 > $MEM_DUMP_PATH/register_config
    echo 0x17a30d00 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17a30d10 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a30d30 0x140 > $MEM_DUMP_PATH/register_config
    echo 0x17a30fb0 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a30fd0 0x140 > $MEM_DUMP_PATH/register_config
    echo 0x17a31250 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17a31270 0x140 > $MEM_DUMP_PATH/register_config
    echo 0x17a33d44 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17a33d4c 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17a33e00 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17a80000 0x40 > $MEM_DUMP_PATH/register_config
    echo 0x17a81000 0x28 > $MEM_DUMP_PATH/register_config
    echo 0x17a82000 0x18 > $MEM_DUMP_PATH/register_config
    echo 0x17a83000 0x400 > $MEM_DUMP_PATH/register_config
    echo 0x17a84000 0x40 > $MEM_DUMP_PATH/register_config
    echo 0x17a85000 0x28 > $MEM_DUMP_PATH/register_config
    echo 0x17a86000 0x18 > $MEM_DUMP_PATH/register_config
    echo 0x17a87000 0x400 > $MEM_DUMP_PATH/register_config
    echo 0x17a88000 0x40 > $MEM_DUMP_PATH/register_config
    echo 0x17a89000 0x28 > $MEM_DUMP_PATH/register_config
    echo 0x17a8a000 0x18 > $MEM_DUMP_PATH/register_config
    echo 0x17a8b000 0x400 > $MEM_DUMP_PATH/register_config
    echo 0x17a90000 0x5c > $MEM_DUMP_PATH/register_config
    echo 0x17a90080 0x24 > $MEM_DUMP_PATH/register_config
    echo 0x17a900ac 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17a900cc 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17a90100 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17a92000 0x5c > $MEM_DUMP_PATH/register_config
    echo 0x17a92080 0x24 > $MEM_DUMP_PATH/register_config
    echo 0x17a920ac 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17a920cc 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17a92100 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17a94000 0x5c > $MEM_DUMP_PATH/register_config
    echo 0x17a94080 0x24 > $MEM_DUMP_PATH/register_config
    echo 0x17a940ac 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17a940cc 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17a94100 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17aa0004 0x20 > $MEM_DUMP_PATH/register_config
    echo 0x17aa0028 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17aa003c 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17aa0054 0x78 > $MEM_DUMP_PATH/register_config
    echo 0x17b00000 0x118 > $MEM_DUMP_PATH/register_config
    echo 0x17b78000 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17b78010 0x20 > $MEM_DUMP_PATH/register_config
    echo 0x17b78090 0x14 > $MEM_DUMP_PATH/register_config
    echo 0x17b78100 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17b78110 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17b78190 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17b781a0 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17b78220 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17b782a0 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17b78320 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17b78380 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17b78390 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17b78410 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17b78420 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17b784a0 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17b78520 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17b78580 0x18 > $MEM_DUMP_PATH/register_config
    echo 0x17b78600 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17b78610 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17b78690 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17b78710 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17b78790 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17b78810 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17b78890 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17b78910 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17b78990 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17b78a10 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17b78a90 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17b78b00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17b78b10 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17b78b90 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17b78c10 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17b78c90 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17b78d10 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17b78d90 0x30 > $MEM_DUMP_PATH/register_config
    echo 0x17b78e00 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17b78e10 0x28 > $MEM_DUMP_PATH/register_config
    echo 0x17b78e90 0x28 > $MEM_DUMP_PATH/register_config
    echo 0x17b78f10 0x28 > $MEM_DUMP_PATH/register_config
    echo 0x17b78f90 0x28 > $MEM_DUMP_PATH/register_config
    echo 0x17b79010 0x28 > $MEM_DUMP_PATH/register_config
    echo 0x17b79090 0x28 > $MEM_DUMP_PATH/register_config
    echo 0x17b79100 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17b79110 0x20 > $MEM_DUMP_PATH/register_config
    echo 0x17b79190 0x20 > $MEM_DUMP_PATH/register_config
    echo 0x17b79210 0x200 > $MEM_DUMP_PATH/register_config
    echo 0x17b79a10 0x20 > $MEM_DUMP_PATH/register_config
    echo 0x17b79a90 0x20 > $MEM_DUMP_PATH/register_config
    echo 0x17b79b00 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17b79b10 0x20 > $MEM_DUMP_PATH/register_config
    echo 0x17b79b90 0x14 > $MEM_DUMP_PATH/register_config
    echo 0x17b79bb0 0x20 > $MEM_DUMP_PATH/register_config
    echo 0x17b79c30 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17b79c40 0x20 > $MEM_DUMP_PATH/register_config
    echo 0x17b79cc0 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17b79d00 0x2c > $MEM_DUMP_PATH/register_config
    echo 0x17ba0000 0x18 > $MEM_DUMP_PATH/register_config
    echo 0x17ba0020 0x14 > $MEM_DUMP_PATH/register_config
    echo 0x17ba0050 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17ba0070 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17ba0080 0x64 > $MEM_DUMP_PATH/register_config
    echo 0x17ba0100 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17ba0120 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17ba0140 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17ba0200 0x40 > $MEM_DUMP_PATH/register_config
    echo 0x17ba0700 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17ba070c 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17ba0780 0x80 > $MEM_DUMP_PATH/register_config
    echo 0x17ba0808 0x18 > $MEM_DUMP_PATH/register_config
    echo 0x17ba0824 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17ba0840 0x40 > $MEM_DUMP_PATH/register_config
    echo 0x17ba0c48 0x18 > $MEM_DUMP_PATH/register_config
    echo 0x17ba0c64 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17ba0c80 0x40 > $MEM_DUMP_PATH/register_config
    echo 0x17ba1088 0x18 > $MEM_DUMP_PATH/register_config
    echo 0x17ba10a4 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17ba10c0 0x40 > $MEM_DUMP_PATH/register_config
    echo 0x17ba3500 0x1e0 > $MEM_DUMP_PATH/register_config
    echo 0x17ba3a80 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17ba3aa8 0xc8 > $MEM_DUMP_PATH/register_config
    echo 0x17ba3c00 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17ba3c20 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17ba3c30 0x20 > $MEM_DUMP_PATH/register_config
    echo 0x17ba3c60 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17ba3c70 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c000e8 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17c00100 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c00110 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c00124 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c00134 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c00144 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c00154 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c00164 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c00174 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c00184 0x20 > $MEM_DUMP_PATH/register_config
    echo 0x17c001ac 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c001bc 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c001cc 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c001dc 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c01000 0x2c > $MEM_DUMP_PATH/register_config
    echo 0x17c01034 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c01044 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c01054 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c01064 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c01074 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c01084 0x34 > $MEM_DUMP_PATH/register_config
    echo 0x17c010c0 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c010d0 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c010e0 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c010f0 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c01100 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c01110 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c01120 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c01130 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c01140 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c01150 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c01160 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c01174 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c01184 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c01198 0x18 > $MEM_DUMP_PATH/register_config
    echo 0x17c011b8 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c011c8 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c20000 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c40000 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c40010 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c40020 0x20 > $MEM_DUMP_PATH/register_config
    echo 0x17c41000 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c41010 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c44000 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17c44100 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c44208 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c44304 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c44500 0x18 > $MEM_DUMP_PATH/register_config
    echo 0x17c45000 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c4500c 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45014 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c45030 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45040 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c4504c 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45054 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c45070 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45080 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c4508c 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45094 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c450b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c450c0 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c450cc 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c450d4 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c450f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45100 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c4510c 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45114 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c45130 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45140 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c4514c 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45154 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c45170 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45180 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c4518c 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45194 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c451b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c451c0 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c451cc 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c451d4 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c451f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45200 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c4520c 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45214 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c45230 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45240 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c4524c 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45254 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c45270 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45280 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c4528c 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45294 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c452b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c452c0 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c452cc 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c452d4 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c452f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45300 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c4530c 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45314 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c45330 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45340 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c4534c 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45354 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c45370 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45380 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c4538c 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45394 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c453b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c453c0 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c453cc 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c453d4 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c453f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45400 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c4540c 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45414 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c45430 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45440 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c4544c 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45454 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c45470 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45480 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c4548c 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45494 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c454b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c454c0 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c454cc 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c454d4 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c454f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45500 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c4550c 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45514 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c45530 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45540 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c4554c 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45554 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c45570 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45580 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c4558c 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45594 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c455b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c455c0 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c455cc 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c455d4 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c455f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45600 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c4560c 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45614 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c45630 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45640 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c4564c 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45654 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c45670 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45680 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c4568c 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45694 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c456b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c456c0 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c456cc 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c456d4 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c456f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45700 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c4570c 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45714 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c45730 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45740 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c4574c 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45754 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c45770 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45780 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c4578c 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c45794 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c457b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c457c0 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17c457cc 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17c457d4 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17c457f0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17d80000 0x1c > $MEM_DUMP_PATH/register_config
    echo 0x17d80100 0x320 > $MEM_DUMP_PATH/register_config
    echo 0x17d90000 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17d90014 0x68 > $MEM_DUMP_PATH/register_config
    echo 0x17d90080 0x14 > $MEM_DUMP_PATH/register_config
    echo 0x17d900b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17d900b8 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17d900d0 0x24 > $MEM_DUMP_PATH/register_config
    echo 0x17d90100 0xa0 > $MEM_DUMP_PATH/register_config
    echo 0x17d90200 0xa0 > $MEM_DUMP_PATH/register_config
    echo 0x17d90300 0x14 > $MEM_DUMP_PATH/register_config
    echo 0x17d90320 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17d90340 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17d9034c 0x7c > $MEM_DUMP_PATH/register_config
    echo 0x17d903e0 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17d90404 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17d90410 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17d91000 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17d91014 0x68 > $MEM_DUMP_PATH/register_config
    echo 0x17d91080 0x28 > $MEM_DUMP_PATH/register_config
    echo 0x17d910b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17d910b8 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17d910d0 0x24 > $MEM_DUMP_PATH/register_config
    echo 0x17d91100 0xa0 > $MEM_DUMP_PATH/register_config
    echo 0x17d91200 0xa0 > $MEM_DUMP_PATH/register_config
    echo 0x17d91300 0x14 > $MEM_DUMP_PATH/register_config
    echo 0x17d91320 0x18 > $MEM_DUMP_PATH/register_config
    echo 0x17d91340 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17d9134c 0xb0 > $MEM_DUMP_PATH/register_config
    echo 0x17d91404 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17d91410 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17d92000 0x10 > $MEM_DUMP_PATH/register_config
    echo 0x17d92014 0x68 > $MEM_DUMP_PATH/register_config
    echo 0x17d92080 0x18 > $MEM_DUMP_PATH/register_config
    echo 0x17d920b0 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17d920b8 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17d920d0 0x24 > $MEM_DUMP_PATH/register_config
    echo 0x17d92100 0xa0 > $MEM_DUMP_PATH/register_config
    echo 0x17d92200 0xa0 > $MEM_DUMP_PATH/register_config
    echo 0x17d92300 0x14 > $MEM_DUMP_PATH/register_config
    echo 0x17d92320 0x8 > $MEM_DUMP_PATH/register_config
    echo 0x17d92340 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17d9234c 0x84 > $MEM_DUMP_PATH/register_config
    echo 0x17d923e0 0xc > $MEM_DUMP_PATH/register_config
    echo 0x17d92404 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17d92410 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17d98000 0x28 > $MEM_DUMP_PATH/register_config
    echo 0x17d9803 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17d98030 0x4  > $MEM_DUMP_PATH/register_config
    echo 0x17D00000 0x10000 > $MEM_DUMP_PATH/register_config
}

enable_cpuss_register()
{
    echo 1 > /sys/bus/platform/devices/soc:mem_dump/register_reset

    format_ver=1
    if [ -r /sys/bus/platform/devices/soc:mem_dump/format_version ]; then
        format_ver=$(cat /sys/bus/platform/devices/soc:mem_dump/format_version)
    fi
    MEM_DUMP_PATH="/sys/bus/platform/devices/soc:mem_dump"
    configure_cpuss_reg
}

create_stp_policy()
{
    mkdir /config/stp-policy/coresight-stm:p_ost.policy
    chmod 660 /config/stp-policy/coresight-stm:p_ost.policy
    mkdir /config/stp-policy/coresight-stm:p_ost.policy/default
    chmod 660 /config/stp-policy/coresight-stm:p_ost.policy/default
    echo 0x10 > /sys/bus/coresight/devices/coresight-stm/traceid
}

#function to enable cti flush for etf
enable_cti_flush_for_etf()
{
    # bail out if its perf config
    if [ ! -d /sys/module/msm_rtb ]
    then
        return
    fi

    echo 1 >/sys/bus/coresight/devices/coresight-cti-swao_cti/enable
    echo 0 24 >/sys/bus/coresight/devices/coresight-cti-swao_cti/channels/trigin_attach
    echo 0 1 >/sys/bus/coresight/devices/coresight-cti-swao_cti/channels/trigout_attach
}

ftrace_disable=`getprop persist.debug.ftrace_events_disable`
coresight_config=`getprop persist.debug.coresight.config`
tracefs=/sys/kernel/tracing
srcenable="enable"
enable_debug()
{
    echo "ravelin debug"
    etr_size="0x2000000"
    srcenable="enable_source"
    sinkenable="enable_sink"
    create_stp_policy
    echo "Enabling STM events on ravelin."
    adjust_permission
    enable_stm_events
    enable_cti_flush_for_etf
    enable_lpm_with_dcvs_tracing
    if [ "$ftrace_disable" != "Yes" ]; then
        enable_ftrace_event_tracing
    fi
    # removing core hang config from postboot as core hang detection is enabled from sysini
    # enable_core_hang_config
    enable_dcc
    #enable_cpuss_hw_events
    enable_schedstats
    setprop ro.dbg.coresight.stm_cfg_done 1
    enable_cpuss_register
    enable_memory_debug
    if [ -d $tracefs ] && [ "$(getprop persist.vendor.tracing.enabled)" -eq "1" ]; then
        mkdir $tracefs/instances/hsuart
        #UART
        echo 800 > $tracefs/instances/hsuart/buffer_size_kb
        echo 1 > $tracefs/instances/hsuart/events/serial/enable
        echo 1 > $tracefs/instances/hsuart/tracing_on

        #SPI
        mkdir $tracefs/instances/spi_qup
        echo 1 > $tracefs/instances/spi_qup/events/qup_spi_trace/enable
        echo 1 > $tracefs/instances/spi_qup/tracing_on

        #I2C
        mkdir $tracefs/instances/i2c_qup
        echo 1 > $tracefs/instances/i2c_qup/events/qup_i2c_trace/enable
        echo 1 > $tracefs/instances/i2c_qup/tracing_on

        #GENI_COMMON
        mkdir $tracefs/instances/qupv3_common
        echo 1 > $tracefs/instances/qupv3_common/events/qup_common_trace/enable
        echo 1 > $tracefs/instances/qupv3_common/tracing_on

        #SLIMBUS
        mkdir $tracefs/instances/slimbus
        echo 1 > $tracefs/instances/slimbus/events/slimbus/slimbus_dbg/enable
        echo 1 > $tracefs/instances/slimbus/tracing_on
    fi
}



enable_debug
