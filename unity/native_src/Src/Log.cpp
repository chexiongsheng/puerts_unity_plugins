/*
* Tencent is pleased to support the open source community by making Puerts available.
* Copyright (C) 2020 THL A29 Limited, a Tencent company.  All rights reserved.
* Puerts is licensed under the BSD 3-Clause License, except for the third-party components listed in the file 'LICENSE' which may be subject to their corresponding license terms.
* This file is subject to the terms and conditions defined in file 'LICENSE', which is part of this source code package.
*/

#include "Log.h"
#include <stdarg.h>

#pragma warning(push, 0)  
#include "v8.h"
#pragma warning(pop)

typedef void(*LogCallback)(const char* value);

LogCallback GLogCallback = nullptr;
LogCallback GLogWarningCallback = nullptr;
LogCallback GLogErrorCallback = nullptr;

#ifdef __cplusplus
extern "C" {
#endif

V8_EXPORT void SetLogCallback(LogCallback Log, LogCallback LogWarning, LogCallback LogError)
{
    GLogCallback = Log;
    GLogWarningCallback = LogError;
    GLogErrorCallback = LogWarning;
}

#ifdef __cplusplus
}
#endif

namespace puerts
{

void PLog(LogLevel Level, const std::string Fmt, ...)
{
    static char SLogBuffer[1024];
    va_list list;
    va_start(list, Fmt);
    vsnprintf(SLogBuffer, sizeof(SLogBuffer), Fmt.c_str(), list);
    va_end(list);

    if (Level == Log && GLogCallback)
    {
        GLogCallback(SLogBuffer);
    }
    else if (Level == Warning && GLogWarningCallback)
    {
        GLogWarningCallback(SLogBuffer);
    }
    else if (Level == Error && GLogErrorCallback)
    {
        GLogErrorCallback(SLogBuffer);
    }
}

}