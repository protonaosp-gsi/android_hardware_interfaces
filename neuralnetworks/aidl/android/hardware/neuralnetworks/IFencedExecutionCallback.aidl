/*
 * Copyright (C) 2020 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package android.hardware.neuralnetworks;

import android.hardware.neuralnetworks.ErrorStatus;
import android.hardware.neuralnetworks.Timing;

/**
 * IFencedExecutionCallback can be used to query the error status result and duration information
 * from an IPreparedModel::executeFenced call.
 */
@VintfStability
interface IFencedExecutionCallback {
    /**
     * The getExecutionInfo method is used by the clients to query error status result and duration
     * information. The method must only be called after the actual evaluation has finished or
     * resulted in an runtime error, as indicated by the status of the sync fence returned by the
     * IPreparedModel::executeFenced call, otherwise GENERAL_FAILURE must be returned.
     *
     * @param out timingLaunched The duration starts when executeFenced is called and ends when
     *                           executeFenced signals the returned syncFence. Unless measureTiming
     *                           was set to true when launching the execution and status is NONE,
     *                           all times must be reported as -1. A driver may choose to report any
     *                           time as -1, indicating that particular measurement is not
     *                           available.
     * @param out timingFenced The duration starts when all waitFor sync fences have been signaled
     *                         and ends when executeFenced signals the returned syncFence. Unless
     *                         measureTiming was set to true when launching the execution and status
     *                         is NONE, all times must be reported as -1. A driver may choose to
     *                         report any time as -1, indicating that particular measurement is not
     *                         available.
     * @return Error status returned from the asynchronously dispatched execution must be:
     *     - NONE if the asynchronous execution was successful
     *     - DEVICE_UNAVAILABLE if driver is offline or busy
     *     - GENERAL_FAILURE if the asynchronous task resulted in an unspecified error
     *     - MISSED_DEADLINE_* if the execution is aborted because it cannot be completed by the
     *       deadline
     *     - RESOURCE_EXHAUSTED_* if the task was aborted by the driver
     */
    ErrorStatus getExecutionInfo(out Timing timingLaunched, out Timing timingFenced);
}
